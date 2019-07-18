defmodule Prime do
  defguard valid_count(count) when count > 0
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when valid_count(count) do
    make_prime_list((for x <- 2..100000, do: x),0)
    |> Enum.at(count-1)
  end

  defp make_prime_list(list,x) do
    xth = Enum.at(list, x)
    cond do
      xth * xth > List.last(list) -> list
      true -> make_prime_list(list -- Enum.filter(list, fn v -> v >= xth * xth and rem(v,xth) === 0 end), x+1)
    end
  end
end
