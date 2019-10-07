defmodule Pooly.WorkerSupervisor do
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg)
  end

  def init(_init_arg) do
    options = [strategy: :one_for_one]
    Supervisor.init([], options)
  end
end
