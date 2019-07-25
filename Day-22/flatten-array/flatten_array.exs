defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    list
    |> flattenning([])
  end

  defp flattenning([], f_list), do: f_list
  defp flattenning([h|t],f_list) when is_nil(h), do: flattenning(t,f_list)
  defp flattenning([h|t],f_list) when not is_list(h), do: flattenning(t,f_list ++ [h])
  defp flattenning([h|t],f_list), do: flattenning(t, f_list ++ flattenning(h, []))

end
