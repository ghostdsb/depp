defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.reduce([],fn x,acc -> acc ++ get_matches(x,base) end)
    |> List.flatten
  end

  defp get_matches(member, base) do
    cond do
      anagram_but_not_equal?(get_charlist(member),get_charlist(base)) -> [member]
      true -> []
    end
  end

  defp anagram_but_not_equal?(cl_m,cl_b), do: cl_m !== cl_b && Enum.sort(cl_m) === Enum.sort(cl_b)

  defp get_charlist(string) do
    string |> String.downcase |> String.to_charlist
  end

end
