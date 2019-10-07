defmodule Pooly.Server do
  use GenServer
  require Logger

  # CLIENT API

  def start_link(pools_config) do
    # Logger.info(inspect(pools_config))
    GenServer.start_link(__MODULE__, pools_config, name: __MODULE__)
  end

  def checkout(pool_name) do
    GenServer.call(:"#{pool_name}Server", :checkout)
  end

  def checkin(pool_name, worker_pid) do
    GenServer.cast(:"#{pool_name}Server", {:checkin, worker_pid})
  end

  def status(pool_name) do
    GenServer.call(:"#{pool_name}Server", :status)
  end

  # SERVER API

  def init(pools_config) do
    # Logger.info(inspect(pools_config))
    pools_config
    |> Enum.each(fn pool_config ->
    send(self(), {:start_pool, [pool_config]}) end)
    {:ok, pools_config}
  end

  def handle_info({:start_pool, [pool_config]}, state) do
    # Logger.info(inspect(pool_config[:name]))
    Supervisor.start_child(Pooly.PoolsSupervisor,
    %{
      id: :"#{pool_config[:name]}Supervisor",
      start: {Pooly.PoolSupervisor, :start_link, [pool_config]},
      type: :supervisor
    })
    # Supervisor.child_spec({Pooly.PoolSupervior, [pool_config]}, id: :"#{pool_config[:name]}Supervisor", type: :supervisor))
    {:noreply, state}
  end

end
