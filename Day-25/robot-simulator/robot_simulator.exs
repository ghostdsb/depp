defmodule RobotSimulator do

  use GenServer

  @directions [:north, :east, :west, :south]

  ##Client API
  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, _position) when direction not in @directions do
    {:error, "invalid direction"}
  end
  def create(direction, {x, y}) when is_number(x) and is_number(y) do
    init_state = %{direction: direction, position: {x, y}}
    {:ok, robot_id} = GenServer.start_link(__MODULE__, init_state, [])
    robot_id
  end
  def create(_, _) , do: {:error, "invalid position"}

  def simulate(robot_id, instructions) do
    GenServer.call(robot_id, {:simulate, instructions})
  end

  def direction(robot_id) do
    GenServer.call(robot_id, :direction)
  end

  def position(robot_id) do
    GenServer.call(robot_id, :position)
  end

  ## Server calls

  def init(init_state) do
    {:ok, init_state}
  end

  def handle_call({:simulate, instruction}, _from, state) do
    movement(do_simulate(state,instruction),state)
  end

  def handle_call(:direction, _from, state) do
    {:reply, give_direction(state), state}
  end

  def handle_call(:position, _from, state) do
    {:reply, give_position(state), state}
  end

  ## Helper functions

  defp movement({:error, msg},state), do: {:reply, {:error, msg}, state}
  defp movement(robot,_), do: {:reply, self(), robot}

  defp  do_simulate(robot, instructions) do
    case valid_instructions?(instructions) do
      true -> move(robot, instructions)
      false -> {:error, "invalid instruction"}
    end
  end


  defp give_direction(robot) do
    robot[:direction]
  end


  defp give_position(robot) do
    robot[:position]
  end

  defp valid_instructions?(instructions) do
    instructions
    |> String.codepoints
    |> Enum.any?(&(&1 !== "R" and &1 !== "L" and &1 !== "A"))
    |> (&(!&1)).()
  end

  defp move(robot, instructions) do
    instructions
    |> String.codepoints
    |> Enum.reduce(robot,fn x,state->update(state,x) end)
  end

  defp update(robot, "R") do
    Map.update!(robot, :direction, fn dir ->
      case dir do
        :north -> :east
        :east -> :south
        :south -> :west
        :west -> :north
      end
    end)
  end

  defp update(robot, "L") do
  Map.update!(robot, :direction, fn dir ->
      case dir do
        :north -> :west
        :east -> :north
        :south -> :east
        :west -> :south
      end
    end)
  end

  defp update(robot, "A") do
    case give_direction(robot) do
      :north -> Map.update!(robot, :position, fn {x,y}-> {x,y+1} end)
      :east -> Map.update!(robot, :position, fn {x,y}-> {x+1,y} end)
      :south -> Map.update!(robot, :position, fn {x,y}-> {x,y-1} end)
      :west -> Map.update!(robot, :position, fn {x,y}-> {x-1,y} end)
    end
  end
end
