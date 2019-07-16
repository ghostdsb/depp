defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b -> :equal
      a === [] -> :sublist
      b === [] -> :superlist
      String.contains?(Enum.reduce(a,"",&(&2<>to_string(&1)<>" ")),[Enum.reduce(b,"",&(&2<>to_string(&1)<>" "))]) -> :superlist
      String.contains?(Enum.reduce(b,"",&(&2<>to_string(&1)<>" ")),[Enum.reduce(a,"",&(&2<>to_string(&1)<>" "))]) -> :sublist
      true -> :unequal
    end
  end
end
