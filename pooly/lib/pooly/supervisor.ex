defmodule Pooly.Supervisor do
  use Supervisor
  require Logger

  def start_link(pools_config) do
    Supervisor.start_link(__MODULE__, pools_config, name: __MODULE__)
  end

  def init(pools_config) do
    children = [
      # Supervisor.child_spec(
      #   {Pooly.PoolsSupervisor, []}, id: Pooly.PoolsSupervisor, type: :supervisor

      #   ),
      # Supervisor.child_spec({Pooly.Server, pools_config}, id: Pooly.Server)
      %{
        id: Pooly.PoolsSupervisor,
        start: {Pooly.PoolsSupervisor, :start_link, []},
        type: :supervisor
      },
      {Pooly.Server, pools_config}
    ]
    opts = [strategy: :one_for_all]

    Supervisor.init(children, opts)
  end

end
