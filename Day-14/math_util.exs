defmodule MathUtil do

  def power(_,0), do: 1
  def power(n,x), do: power(n,x,1)
  defp power(_,0,p), do: p
  defp power(n,x,p), do: power(n,x-1, n*p)

  def factorial(n) when n<0, do: nil
  def factorial(n) when n>=0, do: factorial(n,1)
  defp factorial(0,fact), do: fact
  defp factorial(n, fact), do: factorial(n-1, fact*n)

  def sum_to(number) do
    1..number
    |> Enum.reduce(0, &(&2 + &1))
  end

  def sum_of_square(number) do
    1..number
    |> Enum.reduce(0, &(&2 + &1*&1))
  end

  def square_of_sum(number) do
    sum_to(number)
    |> power(2)
  end

end
