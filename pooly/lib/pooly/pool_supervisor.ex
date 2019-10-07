defmodule Pooly.PoolSupervisor do
  use Supervisor
  require Logger

  def start_link(pool_config) do
    Supervisor.start_link(__MODULE__, pool_config, name: :"#{pool_config[:name]}Supervisor")
  end

  def init(pool_config) do
    Logger.info(inspect(pool_config))
    children = [
      Supervisor.child_spec({Pooly.PoolServer, [self(), pool_config]}, id: :"#{pool_config[:name]}Server")
    ]
    opts = [strategy: :one_for_all]

    Supervisor.init(children, opts)
  end

end
