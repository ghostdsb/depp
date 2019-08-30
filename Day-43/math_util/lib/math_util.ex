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


  def hcf(a,b) when a>0 and b>0 do
    cond do
      a > b -> hcf(a,b, rem(a, b))
      true  -> hcf(b,a, rem(b, a))
    end
  end
  defp hcf(_,h,0), do: h
  defp hcf(_,b,r), do: hcf(b,r, rem(b,r))

  def lcm(a,b) when a>0 and b>0 do
    div( (a*b), hcf(a,b))
  end

  # MathUtil.transpose([[1,2,3],[4,5,6]]) -> [[1,4],[2,5],[3,6]]

  def transpose(mat) do
    mat
    |> List.zip
    |> Enum.map(fn x -> Tuple.to_list(x) end)
  end

  def matrix_multiplication(mat1, mat2) do
    mat1
    |> Enum.map(fn r -> mat2 |> transpose |> Enum.map(fn c -> Enum.zip(r,c) end) end)
    |> Enum.map(fn x -> Enum.map(x,fn el-> dot(el) end)end)
  end

  def dot(list) do
    list
    |> Enum.reduce(0, fn {a,b}, acc -> acc + a*b end)
  end
end
