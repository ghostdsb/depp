defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    %{}
    |> parse_details(input)
    |> Map.to_list
    |> complete_table([])
    |> Enum.sort(&(get_points(&1) >= get_points(&2)))
    |> printer(String.pad_trailing("Team", 30)<>" | "<>String.pad_leading("MP", 2)<>" | "<>String.pad_leading("W", 2)<>" | "<>String.pad_leading("D", 2)<>" | "<>String.pad_leading("L", 2)<>" | "<>String.pad_leading("P", 2))
  end

  def parse_details(table, []), do: table
  def parse_details(table, [head|tail]) do
    table
    |> parse_match_result(String.split(head,";"))
    |> parse_details(tail)
  end

  defp parse_match_result(table, [x, y, "win"]) do
    updated = Map.update(table, x, %{"win" => 1, "loss" => 0, "draw" => 0},
    &(Map.update(&1, "win", 1, fn a -> a + 1 end)))
    Map.update(updated, y, %{"win" => 0, "loss" => 1, "draw" => 0},
    &(Map.update(&1, "loss", 1, fn a -> a + 1 end)))
  end

  defp parse_match_result(table, [x, y, "loss"]) do
    updated = Map.update(table, x, %{"win" => 0, "loss" => 1, "draw" => 0},
    &(Map.update(&1, "loss", 1, fn a -> a + 1 end)))
    Map.update(updated, y, %{"win" => 1, "loss" => 0, "draw" => 0},
    &(Map.update(&1, "win", 1, fn a -> a + 1 end)))
  end

  defp parse_match_result(table, [x, y, "draw"]) do
    updated = Map.update(table, x, %{"win" => 0, "loss" => 0, "draw" => 1},
    &(Map.update(&1, "draw", 1, fn a -> a + 1 end)))
    Map.update(updated, y, %{"win" => 0, "loss" => 0, "draw" => 1},
    &(Map.update(&1, "draw", 1, fn a -> a + 1 end)))
  end

  defp parse_match_result(table,_), do: table

  defp complete_table([],result), do: result
  defp complete_table([{team,result}|tail],complete_result) do
    updated_mp = Map.put(result, "mp", result["win"]+result["loss"]+result["draw"])
    updated_points = Map.put(updated_mp, "points", updated_mp["win"]*3+updated_mp["loss"]*0+updated_mp["draw"]*1)
    complete_table(tail,complete_result ++ [{team,updated_points}])
  end

  defp add_name_padding(string), do: String.pad_trailing(string, 30)
  defp add_numb_padding(numb), do: String.pad_leading(to_string(numb), 2)

  defp get_points({_,map}), do: map["points"]

  defp printer([],table), do: table
  defp printer([{team,result}|tail],table) do
    printer(tail,table <> "\n" <> add_name_padding(team) <>" | "<> add_numb_padding(result["mp"]) <>" | "<> add_numb_padding(result["win"])
    <>" | "<> add_numb_padding(result["draw"]) <>" | "<> add_numb_padding(result["loss"]) <>" | "<> add_numb_padding(result["points"]))
  end
end
