defmodule Pooly.PoolsSupervisor do
  use Supervisor
  require Logger

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    children = []
    opts = [strategy: :one_for_one]

    Supervisor.init(children, opts)
  end
end
