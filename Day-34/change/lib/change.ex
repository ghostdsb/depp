defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(_, 0), do: {:ok, []}

  def generate(coins, target) do
    c = coins |> Enum.sort()
    cond do
      target < hd(c) -> {:error, "cannot change"}
      true -> coins
      |> Enum.sort(&(&1 > &2))
      |> coin_stack(target, [])
      |> answer
    end
  end

  defp answer([]), do: {:error, "cannot change"}
  defp answer(stack), do: {:ok, stack}

  def coin_stack(_,0,running_change), do: running_change
  def coin_stack([],_,_), do: []
  def coin_stack(coins = [coin|rest], target, running_change) do
    cond do
      target - coin === 0 -> [coin|running_change]
      target - coin < hd(Enum.sort(coins)) -> coin_stack(rest, target, running_change)
      true ->
        cs1 = coin_stack(coins, target - coin, [coin| running_change])
        cs2 = coin_stack(rest, target, running_change)
        cond do
          cs1 == [] -> cs2
          cs2 == [] -> cs1
          length(cs1) > length(cs2) -> cs2
          true -> cs1
        end
    end
  end

end
