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

  @grid_state %{
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
  }

  # defstruct(
  #   gridstate: %{
  #     0 => %{
  #       0 => @cell_type[:unknown],
  #       1 => @cell_type[:unknown],
  #       2 => @cell_type[:unknown],
  #       3 => @cell_type[:unknown],
  #       4 => @cell_type[:unknown],
  #       5 => @cell_type[:unknown],
  #       6 => @cell_type[:unknown],
  #       7 => @cell_type[:unknown],
  #       8 => @cell_type[:unknown],
  #       9 => @cell_type[:unknown]
  #     },
  #     1 => %{
  #       0 => @cell_type[:unknown],
  #       1 => @cell_type[:unknown],
  #       2 => @cell_type[:unknown],
  #       3 => @cell_type[:unknown],
  #       4 => @cell_type[:unknown],
  #       5 => @cell_type[:unknown],
  #       6 => @cell_type[:unknown],
  #       7 => @cell_type[:unknown],
  #       8 => @cell_type[:unknown],
  #       9 => @cell_type[:unknown]
  #     },
  #     2 => %{
  #       0 => @cell_type[:unknown],
  #       1 => @cell_type[:unknown],
  #       2 => @cell_type[:unknown],
  #       3 => @cell_type[:unknown],
  #       4 => @cell_type[:unknown],
  #       5 => @cell_type[:unknown],
  #       6 => @cell_type[:unknown],
  #       7 => @cell_type[:unknown],
  #       8 => @cell_type[:unknown],
  #       9 => @cell_type[:unknown]
  #     },
  #     3 => %{
  #       0 => @cell_type[:unknown],
  #       1 => @cell_type[:unknown],
  #       2 => @cell_type[:unknown],
  #       3 => @cell_type[:unknown],
  #       4 => @cell_type[:unknown],
  #       5 => @cell_type[:unknown],
  #       6 => @cell_type[:unknown],
  #       7 => @cell_type[:unknown],
  #       8 => @cell_type[:unknown],
  #       9 => @cell_type[:unknown]
  #     },
  #     4 => %{
  #       0 => @cell_type[:unknown],
  #       1 => @cell_type[:unknown],
  #       2 => @cell_type[:unknown],
  #       3 => @cell_type[:unknown],
  #       4 => @cell_type[:unknown],
  #       5 => @cell_type[:unknown],
  #       6 => @cell_type[:unknown],
  #       7 => @cell_type[:unknown],
  #       8 => @cell_type[:unknown],
  #       9 => @cell_type[:unknown]
  #     },
  #     5 => %{
  #       0 => @cell_type[:unknown],
  #       1 => @cell_type[:unknown],
  #       2 => @cell_type[:unknown],
  #       3 => @cell_type[:unknown],
  #       4 => @cell_type[:unknown],
  #       5 => @cell_type[:unknown],
  #       6 => @cell_type[:unknown],
  #       7 => @cell_type[:unknown],
  #       8 => @cell_type[:unknown],
  #       9 => @cell_type[:unknown]
  #     },
  #     6 => %{
  #       0 => @cell_type[:unknown],
  #       1 => @cell_type[:unknown],
  #       2 => @cell_type[:unknown],
  #       3 => @cell_type[:unknown],
  #       4 => @cell_type[:unknown],
  #       5 => @cell_type[:unknown],
  #       6 => @cell_type[:unknown],
  #       7 => @cell_type[:unknown],
  #       8 => @cell_type[:unknown],
  #       9 => @cell_type[:unknown]
  #     },
  #     7 => %{
  #       0 => @cell_type[:unknown],
  #       1 => @cell_type[:unknown],
  #       2 => @cell_type[:unknown],
  #       3 => @cell_type[:unknown],
  #       4 => @cell_type[:unknown],
  #       5 => @cell_type[:unknown],
  #       6 => @cell_type[:unknown],
  #       7 => @cell_type[:unknown],
  #       8 => @cell_type[:unknown],
  #       9 => @cell_type[:unknown]
  #     },
  #     8 => %{
  #       0 => @cell_type[:unknown],
  #       1 => @cell_type[:unknown],
  #       2 => @cell_type[:unknown],
  #       3 => @cell_type[:unknown],
  #       4 => @cell_type[:unknown],
  #       5 => @cell_type[:unknown],
  #       6 => @cell_type[:unknown],
  #       7 => @cell_type[:unknown],
  #       8 => @cell_type[:unknown],
  #       9 => @cell_type[:unknown]
  #     },
  #     9 => %{
  #       0 => @cell_type[:unknown],
  #       1 => @cell_type[:unknown],
  #       2 => @cell_type[:unknown],
  #       3 => @cell_type[:unknown],
  #       4 => @cell_type[:unknown],
  #       5 => @cell_type[:unknown],
  #       6 => @cell_type[:unknown],
  #       7 => @cell_type[:unknown],
  #       8 => @cell_type[:unknown],
  #       9 => @cell_type[:unknown]
  #     }
  #   },
  #   is_active: true,
  #   score_info: %{
  #     baseScoreAddition: 500,
  #     required_lastlevel_clearscore: 0,
  #     max_level_with_bonus: 4,
  #     next_unlockable: 0,
  #     consecutive_line_clear: 0,
  #     game_session_score: 0
  #   }
  # )

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

  def auto_deploy do
    drop_in(@grid_state)
  end

  def drop_in(grid), do: drop_in(grid, @ship_type[:carrier], random(1))
  def drop_in(grid, 1, _), do: grid
  def drop_in(grid, ship_id, orientation) do
    {x,y} = find_empty_place(grid, ship_id, orientation)
    grid
    |> update_grid(ship_id, orientation, {x,y})
    |> drop_in(ship_id-1, random(1))
    # %{grid | random_row => %{grid[random_row] | random_col => ship_id}}
  end

  def update_grid(grid, ship_id, @horizontal, {x,y}) do
    # x..(x+get_ship_length(ship_id)-1)
    for i<- x..(x+get_ship_length(ship_id)-1), do: %{grid | y => %{grid[y] | i => ship_id}}
  end

  def update_grid(grid, ship_id, @vertical, {x,y}) do
    # y..(y+get_ship_length(ship_id)-1)
    for i<- y..(y+get_ship_length(ship_id)-1), do: %{grid | i => %{grid[i] | x => ship_id}}
  end

  def find_empty_place(grid, ship_id, orientation) do
    {x,y} = get_drop_coordinates()
    cond do
      @grid_width - x < get_ship_length(ship_id) && orientation === @horizontal -> find_empty_place(grid, ship_id, orientation)
      @grid_height - y < get_ship_length(ship_id) && orientation === @vertical -> find_empty_place(grid, ship_id, orientation)
      true -> cond do
        path_not_clear?(grid, ship_id, {x,y},orientation) -> find_empty_place(grid, ship_id, orientation)
        true -> {x,y}
      end
    end
  end

  def path_not_clear?(grid, ship_id, {x,y}, @horizontal) do
    x..(x+get_ship_length(ship_id)-1)
    |> Enum.any?(&(grid[y][&1]!==0))
  end

  def path_not_clear?(grid, ship_id, {x,y}, @vertical) do
    y..(y+get_ship_length(ship_id)-1)
    |> Enum.any?(&(grid[&1][x]!==0))
  end

  def get_drop_coordinates do
    {random(9), random(9)}
  end

  def random(val) do
    0..val
    |> Enum.random
  end

end
