defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count(l) do
    count(l,0)
  end

  defp count([],len), do: len
  defp count([_|t], len) do
    count(t, len+1)
  end

  @spec reverse(list) :: list
  def reverse([]), do: []
  def reverse(l) do
    reverse(l,[])
  end

  defp reverse([],rev), do: rev
  defp reverse([h|t], rev) do
    reverse(t, [h|rev])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    l |> map(f,[]) |> reverse
  end

  defp map([], _, mapped), do: mapped
  defp map([h|t], f, mapped) do
    map(t, f, [f.(h)| mapped])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    l |> filter(f, []) |> reverse
  end

  defp filter([],_,filterred), do: filterred
  defp filter([h|t], f, filterred) do
    cond do
      f.(h) -> filter(t, f, [h|filterred])
      true -> filter(t, f, filterred)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([h|t], acc, f) do
    reduce(t, f.(h,acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    a |> reverse |> add_elements(b)
  end

  defp add_elements([], list), do: list
  defp add_elements([h|t], list) do
    add_elements(t,[h|list])
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    ll |> flatten
  end

  defp flatten(list) do
    list |> flattenning([]) |> reverse()
  end

  defp flattenning([], f_list), do: f_list
  defp flattenning([h|t],f_list) when not is_list(h), do: flattenning(t,[h|f_list])
  defp flattenning([h|t],f_list), do: flattenning(t, append(flattenning(h, []), f_list))
end
