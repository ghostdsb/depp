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
      true -> coins |> Enum.sort(&(&1 > &2)) |> calculate(0, target, target, 0, target, [], [])
    end
  end

  def calculate([], _, _, _, _, _, _, changes), do: {:ok, changes}

  def calculate(
        list = [_ | t],
        index,
        init,
        val,
        change_count,
        min_count,
        running_change,
        changes
      ) do
    cond do
      index === length(list) and val !== 0 ->
        # calculate(t, 0, init, init, 0, change_count, [], running_change)
        {:error, "cannot change"}

      index === length(list) or val === 0 ->
        cond do
          change_count < min_count ->
            calculate(t, 0, init, init, 0, change_count, [], running_change)

          true ->
            calculate(t, 0, init, init, 0, min_count, [], changes)
        end

      true ->
        ith = Enum.at(list, index)

        calculate(
          list,
          index + 1,
          init,
          val - ith * div(val, ith),
          change_count + div(val, ith),
          min_count,
          List.duplicate(ith, div(val, ith)) ++ running_change,
          changes
        )
    end
  end
end

### frequency , g: 63 -1
