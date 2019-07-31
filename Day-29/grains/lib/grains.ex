defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number >= 1 and number <= 64 do
    {:ok, power(2, number - 1)}
  end

  def square(_), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    {:ok, power(2, 64) - 1}
  end

  defp power(_, 0), do: 1
  defp power(n, x), do: power(n, to_binary(x), n)
  defp power(_, [], acc), do: acc
  defp power(n, [0 | bits], acc), do: power(n, bits, acc * acc)
  defp power(n, [1 | bits], acc), do: power(n, bits, acc * acc * n)

  defp to_binary(val), do: to_binary(val, [])
  defp to_binary(1, bits), do: bits
  defp to_binary(val, bits), do: to_binary(div(val, 2), [rem(val, 2) | bits])
end
