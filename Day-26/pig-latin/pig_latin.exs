defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(&(converter(&1)))
    |> Enum.join(" ")
  end

  defp converter(word) do
    vowel_index = word |> first_vowel_index
    <<consonants::binary-size(vowel_index), rest::binary>> = word
    "#{rest}#{consonants}ay"
  end

  defp first_vowel_index(phrase) do
    phrase |> String.codepoints |> finder(0)
  end

  defp finder([], idx), do: idx
  defp finder([a,b,c], idx), do: finder([a,b,c,[]], idx)
  defp finder([h,th|[tth|rest]], idx) do
    cond do
      "#{h}#{th}" in ~w(ch qu th) -> finder([tth|rest], idx + 2)
      "#{h}#{th}#{tth}" in ~w(squ thr sch) -> finder(rest, idx + 3)
      h in ~w(a e i o u) or h in ~w(x y) and th not in ~w(a e i o u)-> idx
      true -> finder([th|[tth|rest]], idx + 1)
    end
  end
end
