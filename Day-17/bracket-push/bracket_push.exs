defmodule BracketPush do
  @bracket_pairs %{
    "{" => "}",
    "(" => ")",
    "[" => "]"
  }
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.codepoints
    |> Enum.reduce([],fn x, acc -> operate(acc,x) end)
    |> (&(length(&1) === 0)).()
  end

  defp operate(list,val) do
    cond do
      Map.has_key?(@bracket_pairs, val) -> push(list,val)
      @bracket_pairs[List.last(list)] === val -> pop(list)
      Enum.member?(Map.values(@bracket_pairs), val) -> push(list, val)
      true -> list
    end
  end
  defp push(list,element), do: list ++ [element]
  defp pop(list) do
    {_, lst} = List.pop_at(list, -1, [])
    lst
  end
end
