defmodule MathUtil do

  def factorial(n) when n<0, do: nil
  def factorial(n) when n>=0, do: factorial(n,1)
  defp factorial(0,fact), do: fact
  defp factorial(n, fact), do: factorial(n-1, fact*n)

  def power(_, 0), do: 1
  def power(n, x), do: power(n, to_binary(x), n)
  defp power(_, [], acc), do: acc
  defp power(n, [0 | bits], acc), do: power(n, bits, acc * acc)
  defp power(n, [1 | bits], acc), do: power(n, bits, acc * acc * n)

  defp to_binary(val), do: to_binary(val, [])
  defp to_binary(1, bits), do: bits
  defp to_binary(val, bits), do: to_binary(div(val, 2), [rem(val, 2) | bits])

end
