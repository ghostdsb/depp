defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..limit-1
    |> Enum.filter(fn x-> divisible_by_members?(x,factors) end)
    |> Enum.sum
  end

  defp divisible_by_members?(number, factors) do
    factors
    |> Enum.reduce(false, fn x,bool -> bool || rem(number,x)===0 end)
  end
end
