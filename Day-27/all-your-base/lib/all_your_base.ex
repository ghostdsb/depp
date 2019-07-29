defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _, _), do: nil
  def convert(digits, base_a, base_b) do
    cond do
      in_valid_digits?(digits, base_a) -> nil
      in_valid_base?(base_a) || in_valid_base?(base_b) -> nil
      true -> digits |> to_base_ten(base_a) |> to_base_b(base_b, [])
    end
    
  end

  defp to_base_ten(digits, base_a) do
    digits
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reduce(0,fn {x,y},acc -> acc + x * power(base_a,y)end)
  end

  defp to_base_b(num, b, digits) do
    cond do
      num >= b -> to_base_b(div(num,b), b, [rem(num,b)| digits])
      true -> [num| digits]
    end
  end

  defp in_valid_digits?(digits, base) do
    digits
    |> Enum.any?(&(&1<0 || &1>= base))
  end

  defp in_valid_base?(base), do: base<=1

  defp power(_,0), do: 1
  defp power(n,x), do: power(n,x,1)
  defp power(_,0,p), do: p
  defp power(n,x,p), do: power(n,x-1, n*p)
end
