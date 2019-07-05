defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split( ~r{[^A-Za-z]}, trim: true)
    |> Enum.reduce("", fn x,ac -> ac<>abbreviate_word(x) end)
  end

  defp is_upcase?(char), do: String.upcase(char) == char

  defp abbreviate_word(word) do
    word
    |> String.codepoints
    |> Enum.reduce("",fn x, ac -> cond do
      ac == "" -> ac<>String.upcase(x)
      is_upcase?(x)-> ac<>x
      true -> ac
      end
    end)
  end

end
