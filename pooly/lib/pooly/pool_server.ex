defmodule Pooly.PoolServer do
  use GenServer
  # import Supervisor.Spec

  defmodule State do
    defstruct(
      pool_sup: nil,
      size: nil,
      mfa: nil,
      worker_sup: nil,
      workers: nil,
      monitors: nil,
      name: nil
    )
  end

  # CLIENT API

  def start_link([pool_sup, pool_config]) do
    GenServer.start_link(__MODULE__, [pool_sup, pool_config], name: name(pool_config[:name]))
  end

  def checkout(pool_name) do
    GenServer.call(name(pool_name), :checkout)
  end

  def checkin(pool_name, worker_pid) do
    GenServer.cast(name(pool_name), {:checkin, worker_pid})
  end

  def status(pool_name) do
    GenServer.call(name(pool_name), :status)
  end

  # SERVER API

  def init([pool_sup, pool_config]) when is_pid(pool_sup) do
    Process.flag(:trap_exit, true)
    monitors = :ets.new(:monitors, [:private])
    init( pool_config, %State{ pool_sup: pool_sup, monitors: monitors} )
  end

  def init([{:mfa, mfa} | rest], state) do
    init(rest, %{state | mfa: mfa})
  end

  def init([{:size, size} | rest], state) do
    init(rest, %{ state | size: size})
  end

  def init([{:name, name} | rest], state) do
    init(rest, %{ state | name: name})
  end

  def init([_|rest], state) do
    init(rest, state)
  end

  def init([], state) do
    send(self(), :start_worker_supervisor)
    {:ok, state}
  end


  def handle_call(:checkout, {from_pid, _ref}, %{monitors: monitors, workers: workers} = state) do
    case workers do
      [worker| rest] ->
        consumer_ref = Process.monitor(from_pid)
        true = :ets.insert(monitors, {worker, consumer_ref})
        {:reply, worker, %{state | workers: rest}}
      [] ->
        {:reply, :noproc, state}
    end
  end

  def handle_call(:status, _from, %{workers: workers, monitors: monitors} = state) do
    {:reply, {length(workers), :ets.info(monitors, :size)}, state}
  end

  def handle_cast({:checkin, worker_pid}, state = %{workers: workers, monitors: monitors}) do
    case :ets.lookup(monitors, worker_pid) do
      [{pid, ref}] ->
        Process.demonitor(ref)
        :ets.delete(monitors, pid)
        {:noreply, %{state | workers: [pid|workers]}}
      [] ->
        {:noreply, state}
    end
  end

  def handle_info(:start_worker_supervisor, state = %{pool_sup: pool_sup, mfa: _mfa, size: _size, name: name}) do
    # {:ok, worker_sup_pid} = Supervisor.start_child(pool_sup, Supervisor.child_spec(Pooly.WorkerSupervisor, id: {WorkerSupervisor}))
    worker_sup_pid = {pool_sup, name} |> start_worker_sup |> get_worker_sup_pid
    workers = populate_workers(worker_sup_pid, state)
    {:noreply, %{state | worker_sup: worker_sup_pid, workers: workers}}
    # {:noreply, state}
  end

  def handle_info({:DOWN, ref, _, _, _}, %{monitors: monitors, workers: workers} = state) do
    case :ets.match(monitors, {:"$1", ref}) do
      [[pid]] ->
        :ets.delete(monitors, pid)
        {:noreply, %{state | workers: [pid|workers]}}
      [] ->
        {:noreply, state}
    end
  end

  def handle_info({:EXIT, pid, _reason}, %{size: size, monitors: monitors, workers: workers, worker_sup: worker_sup, mfa: {m, _f,_a}, name: name} = state) do
    case :ets.lookup(monitors, pid) do
      [{pid, ref}] ->
        true = :ets.delete(monitors, pid)
        true = Process.demonitor(ref)
        {:noreply, %{state| workers: [start_new_worker(worker_sup, name, m, size+1)| workers]}}
      [] ->
        {:noreply, state}
    end
    {:noreply, state}
  end

  # HELPER FUNTIONS

  defp name(pool_name) do
    :"#{pool_name}Server"
  end

  defp populate_workers(worker_sup_pid, %{pool_sup: _sup, mfa: {m,_f,_a}, size: size, name: name}) do
    1..size
    |> Enum.map(fn x -> start_new_worker(worker_sup_pid, name, m, x) end)
    |> Enum.map( fn status ->
      case status do
        {:ok, worker_pid} -> worker_pid
        {:error, {_, worker_pid}} -> worker_pid
      end
    end)
  end

  defp start_worker_sup({pool_sup, name}) do
    Supervisor.start_child(pool_sup, Supervisor.child_spec(Pooly.WorkerSupervisor, id: name<>"WorkerSupervisor", type: :supervisor))
  end

  defp start_new_worker(worker_sup_pid, name, m, i) do
    Supervisor.start_child(worker_sup_pid, Supervisor.child_spec(
      {m, "#{name}worker#{i}"}, id: :"#{name}#{m}#{i}"
    ))
  end

  defp get_worker_sup_pid({:ok, worker_sup}), do: worker_sup
  defp get_worker_sup_pid({:error, {_reason, worker_sup}}), do: worker_sup

end
