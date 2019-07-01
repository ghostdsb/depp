defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    pattern = :binary.compile_pattern([" ", "!", "&", "@", "$", "%", "^", ":", ",", "_"])
    sentence
    |> String.split(pattern, trim: true)
    |> make_map(%{})
  end

  defp make_map([],w_map), do: w_map
  defp make_map([head|tail], w_map) do
    make_map(tail,Map.update(w_map,String.downcase(head),1,&(&1+1)))
  end
end
