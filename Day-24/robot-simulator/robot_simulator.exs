defmodule RobotSimulator do

  use GenServer

  @name __MODULE__
  @directions [:north, :east, :west, :south]

  ##Client API
  def create() do
    start_link(:ok)
  end

  def create(direction, position) do
    start_link({direction, position})
  end

  defp start_link(init_arg, opts\\ []) do
    GenServer.start_link(__MODULE__, init_arg, name: @name)
  end

  def simulate(_, instructions) do
    GenServer.call(@name, {:simulate, instructions})
  end

  def direction(_) do
    GenServer.call(@name, :direction)
  end

  def position(_) do
    GenServer.call(@name, :position)
  end

  ## Server calls

  def init(:ok) do
    {:ok, new()}
  end

  def init({direction, position}) do
    initialize(new(direction, position))
  end

  # def handle_cast({:simulate, instruction}, state) do
  #   movement(do_simulate(state,instruction),state)
  # end

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

  defp initialize({:error, msg}), do: {:stop, msg}
  defp initialize({:ok, robot}), do: {:ok, robot}

  defp movement({:error, msg},state), do: {:reply, {:error, msg}, state}
  defp movement(robot,_), do: {:noreply, robot}

  defp new(), do: %{:direction => :north,   :position => {0,0}}
  defp new(direction, position = {_,_}) do
    cond do
      not valid_direction?(direction) -> {:error, "invalid direction"}
      not valid_position?(position)   -> {:error, "invalid position"}
      true ->  %{:direction => direction,   :position => position}
    end
  end
  defp new(_, _), do: {:error, "invalid position"}


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

  defp valid_direction?(direction) do
    @directions
    |> Enum.any?(&(&1===direction))
  end

  defp valid_position?({x,y}) do
    is_integer(x) && is_integer(y)
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
