defmodule Dilemma do
  @moduledoc """
  Documentation for Dilemma.
  """
  @spec solve(String.t()) :: String.t()
  def solve(cards) do
    cards
    |> String.codepoints
    |> Enum.reduce(0,fn x, acc -> cond do
      x === "1" -> acc + 1
      true -> acc
    end
    end)
    |> (&(rem(&1,2)===1)).()
    |> print_answer
  end

  defp print_answer(true), do: "WIN"
  defp print_answer(_), do: "LOSE"

end
