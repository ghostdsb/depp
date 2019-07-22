defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    search(numbers, 0, tuple_size(numbers)-1, key)
  end
  
  defp search(_,l,r,_) when l > r  do
   :not_found
  end

  defp search(nums,l,r,key) do
    cond do 
      elem(nums,div( l+r , 2)) > key -> search(nums, l, div( l+r , 2)-1, key)
      elem(nums,div( l+r , 2)) < key -> search(nums, div( l+r , 2)+1, r, key)
      true -> {:ok, div(l+r,2)}
    end
  end
end
