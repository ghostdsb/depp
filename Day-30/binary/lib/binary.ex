defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string) do
    cond do
      not valid_binary?(string) -> 0
      true -> convert_to_decimal(string)
    end
  end

  def valid_binary?(string) do
    string
    |> String.codepoints
    |> Enum.map(&(String.to_charlist(&1)))
    |> Enum.any?(&(&1 !=='0' and &1 !=='1'))
    |> (&(!&1)).()
  end

  def convert_to_decimal(string) do
    string
    |> String.codepoints
    |> Enum.map(&(String.to_integer(&1)))
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reduce(0,fn {x,y}, acc -> acc + x*:math.pow(2,y) end)
    |> trunc()
  end
end
