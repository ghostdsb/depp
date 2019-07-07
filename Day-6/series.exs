defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_s, size) when size<=0, do: []
  def slices(s, size) do
    make_slice_list(s,0,size,[])
  end

  defp make_slice_list(s,start,size,acc) do
    cond do
      start + size > String.length(s) -> acc
      true -> make_slice_list(s,start+1,size,acc ++ [String.slice(s,start,size)])
    end
  end
end
