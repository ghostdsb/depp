defmodule RobotSimulator do

  @directions [:north, :east, :west, :south]
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(), do: %{:direction => :north,   :position => {0,0}}
  def create(direction, position = {_,_}) do
    cond do
      not valid_direction?(direction) -> {:error, "invalid direction"}
      not valid_position?(position)   -> {:error, "invalid position"}
      true ->  %{:direction => direction,   :position => position}   
    end
  end
  def create(_, _), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    case valid_instructions?(instructions) do
      true -> move(robot, instructions)
      false -> {:error, "invalid instruction"}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot[:direction]
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
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
    case direction(robot) do
      :north -> Map.update!(robot, :position, fn {x,y}-> {x,y+1} end)
      :east -> Map.update!(robot, :position, fn {x,y}-> {x+1,y} end)
      :south -> Map.update!(robot, :position, fn {x,y}-> {x,y-1} end)
      :west -> Map.update!(robot, :position, fn {x,y}-> {x-1,y} end)
    end
  end
end
