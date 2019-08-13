defmodule BattleshipsArmada.Core.GameState do
  @ship_type %{
    destroyer: 2,
    cruiser: 3,
    submarine: 4,
    battleship: 5,
    carrier: 6
  }

  @cell_type %{
    unknown: 0,
    water: 1,
    hit: 2,
    sunk: 3
  }

  @grid_width 10
  @grid_height 10
  @horizontal 0
  @vertical 1
  @player1 1
  @player2 2

  defstruct(
    gridstate_player1: %{
        0 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        1 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        2 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        3 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        4 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        5 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        6 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        7 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        8 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        9 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        }
      },
      gridstate_player2: %{
        0 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        1 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        2 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        3 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        4 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        5 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        6 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        7 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        8 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        },
        9 => %{
          0 => @cell_type[:unknown],
          1 => @cell_type[:unknown],
          2 => @cell_type[:unknown],
          3 => @cell_type[:unknown],
          4 => @cell_type[:unknown],
          5 => @cell_type[:unknown],
          6 => @cell_type[:unknown],
          7 => @cell_type[:unknown],
          8 => @cell_type[:unknown],
          9 => @cell_type[:unknown]
        }
    },
    current_turn: 1,
    move_count: 0
  )

  @spec get_ship_length(number) :: number
  def get_ship_length(ship_type) do
    cond do
      ship_type == @ship_type[:destroyer] -> 2
      ship_type == @ship_type[:cruiser] -> 3
      ship_type == @ship_type[:submarine] -> 3
      ship_type == @ship_type[:battleship] -> 4
      ship_type == @ship_type[:carrier] -> 5
    end
  end

  @spec auto_deploy(number) :: any
  def auto_deploy(@player1) do
    gamestate = BattleshipsArmada.Core.GameState.__struct__()
    %{gamestate|
    gridstate_player1: drop_in(gamestate.gridstate_player1)  }

  end

  def auto_deploy(@player2) do
    gamestate = BattleshipsArmada.Core.GameState.__struct__()
    %{gamestate|
    gridstate_player2: drop_in(gamestate.gridstate_player2)  }

  end

  @spec update_grid_from_game(map, any, 1 | 2) :: map
  def update_grid_from_game(gamestate, grid, @player1) do
    %{gamestate|
    gridstate_player1: grid  }
  end

  def update_grid_from_game(gamestate, grid, @player2) do
    %{gamestate|
    gridstate_player2: grid  }
  end

  defp drop_in(grid), do: drop_in(grid, @ship_type[:carrier], random(1))
  defp drop_in(grid, 1, _), do: grid

  defp drop_in(grid, ship_id, orientation) do
    {x, y} = find_empty_place(grid, ship_id, orientation)
    grid
    |> place_ship(ship_id, orientation, {x, y})
    |> drop_in(ship_id - 1, random(1))
  end

  defp place_ship(grid, ship_id, @horizontal, {x, y}) do
    x..(x + get_ship_length(ship_id) - 1)
    |> Enum.reduce(grid, fn i,state -> update_grid({i,y}, ship_id, state) end)
  end

  defp place_ship(grid, ship_id, @vertical, {x, y}) do
    y..(y+get_ship_length(ship_id)-1)
    |> Enum.reduce(grid, fn i,state -> update_grid({x,i}, ship_id, state) end)
  end

  defp update_grid({x,y}, ship_id, grid) do
    %{grid | y => %{grid[y] | x => ship_id}}
  end

  defp find_empty_place(grid, ship_id, orientation) do
    {x, y} = get_random_drop_coordinates()

    cond do
      @grid_width - x < get_ship_length(ship_id) && orientation === @horizontal ->
        find_empty_place(grid, ship_id, orientation)

      @grid_height - y < get_ship_length(ship_id) && orientation === @vertical ->
        find_empty_place(grid, ship_id, orientation)

      true ->
        cond do
          path_not_clear?(grid, ship_id, {x, y}, orientation) ->
            find_empty_place(grid, ship_id, orientation)

          true ->
            {x, y}
        end
    end
  end

  defp path_not_clear?(grid, ship_id, {x, y}, @horizontal) do
    x..(x + get_ship_length(ship_id) - 1)
    |> Enum.any?(&(grid[y][&1] !== 0))
  end

  defp path_not_clear?(grid, ship_id, {x, y}, @vertical) do
    y..(y + get_ship_length(ship_id) - 1)
    |> Enum.any?(&(grid[&1][x] !== 0))
  end

  defp get_random_drop_coordinates do
    {random(9), random(9)}
  end

  defp random(val) do
    0..val
    |> Enum.random()
  end

end
