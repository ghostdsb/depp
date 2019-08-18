defmodule ThySupervisor do

  use GenServer
  @moduledoc """
  Documentation for ThySupervisor.
  """
  #############
  # Client API#
  #############

  def start_link(child_spec_list) do
    GenServer.start_link(__MODULE__, [child_spec_list])
  end

  def start_child(supervisor, child_spec) do
    GenServer.call(supervisor, {:start_child, child_spec})
  end

  def terminate_child(supervisor, child_pid) do
    GenServer.call(supervisor, {:terminate_child, child_pid})
  end

  def restart_child(supervisor, child_pid, child_spec) do
    GenServer.call(supervisor, {:restart_child, child_pid, child_spec})
  end

  def count_children(supervisor) do
    GenServer.call(supervisor, :count_children)
  end

  def which_children(supervisor) do
    GenServer.call(supervisor, :which_children)
  end

  #############
  # Server API#
  #############

  @spec init(maybe_improper_list) :: {:ok, any}
  def init([child_spec_list]) do
    Process.flag(:trap_exit, true)
    state = child_spec_list |> start_children |> Enum.into(Map.new)
    {:ok, state}
  end

  def handle_call({:start_child, child_spec}, _from, state) do
    case start_child(child_spec) do
      {:ok, pid} ->
        new_state = state |> Map.put(pid, child_spec)
        {:reply, {:ok, pid}, new_state}
      :error ->
        {:reply, {:error, "error starting process"}, state}
    end
  end

  def handle_call({:terminate_child, child_pid}, _from, state) do
    case terminate_child(child_pid) do
      :ok ->
        new_state = state |> Map.delete(child_pid)
        {:reply, {:ok, child_pid}, new_state}
      :error ->
        {:reply, {:error, "error terminating child"}, state}
    end
  end

  def handle_call({:restart_child, child_pid}, _from, state) do
    case Map.fetch(state, child_pid) do
      {:ok, child_spec} ->
        case restart(child_pid, child_spec) do
          {:ok, {pid, child_spec}} ->
            new_state = state |> Map.delete(child_pid) |> Map.put(pid, child_spec)
            {:reply, {:ok, pid}, new_state}
          :error ->
            {:reply, {:error, "error restarting child"}, state}
        end
       _ ->
        {:reply, :ok, state}
    end
  end

  def handle_call(:count_child, _from, state) do
    {:reply, Map.size(state), state}
  end

  def handle_call(:which_children, _from, state) do
    {:reply, state, state}
  end

  def handle_info({:EXIT, from, :killed}, state) do
    new_state = state |> Map.delete(from)
    {:noreply, new_state}
  end

  def handle_info({:EXIT, from, :normal}, state) do
    new_state = state |> Map.delete(from)
    {:noreply, new_state}
  end

  def handle_info({:EXIT, old_pid, _reason}, state) do
    case Map.fetch(state, old_pid) do
      {:ok, child_specs} ->
        case restart(old_pid, child_specs) do
          {:ok, {new_pid, child_specs}} ->
            new_state = state |> Map.delete(old_pid) |> Map.put(new_pid, child_specs)
            {:noreply, new_state}
          _ -> {:noreply, state}
        end
      _ -> {:noreply, state}
    end
  end

  def terminate(_reason, state) do
    terminate_children(state)
    :ok
  end


  ########
  #Helper#
  ########

  defp start_children([]), do: []
  defp start_children([child_spec| tail]) do
    case start_child(child_spec) do
      {:ok, pid} -> [{pid, child_spec}| start_children(tail)]
      :error -> :error
    end
  end

  defp start_child({mod, fun, args}) do
    case apply(mod, fun, args) do
      pid when is_pid(pid) ->
        Process.link(pid)
        {:ok, pid}
      _ -> :error
    end
  end

  defp terminate_children([]), do: :ok
  defp terminate_children(child_specs) do
    child_specs
    |> Enum.each(fn {pid, _} -> terminate_child(pid) end)
  end

  defp terminate_child(child_pid) do
    Process.exit(child_pid, :kill)
    :ok
  end

  defp restart(child_pid, child_spec) do
    case terminate_child(child_pid) do
      :ok ->
        case start_child(child_spec) do
          {:ok, new_pid} -> {:ok, {new_pid, child_spec}}
          :error -> :error
        end
      :error -> :error
    end
  end
end
