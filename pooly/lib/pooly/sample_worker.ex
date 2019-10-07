defmodule Pooly.SampleWorker do
  use GenServer

  ####Client API#############

  def start_link(_name) do
    GenServer.start_link(__MODULE__, :ok)
  end

  def stop(pid) do
    GenServer.call(pid, :stop)
  end

  #####Server API##########

  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_call(:stop, _from, state) do
    {:stop, :normal, :ok, state}
  end
end
