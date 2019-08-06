defmodule Dilemma do
  @moduledoc """
  Documentation for Dilemma.
  """
  @spec solve(String.t()) :: String.t()
  def solve(cards) do
    cards
    |> String.codepoints
    |> Enum.reduce(0,fn x, acc -> acc + up(x) end)
    |> (&(rem(&1,2)===1)).()
    |> print_answer
  end

  defp up("1"), do: 1
  defp up(_), do: 0

  defp print_answer(true), do: "WIN"
  defp print_answer(_), do: "LOSE"

end
