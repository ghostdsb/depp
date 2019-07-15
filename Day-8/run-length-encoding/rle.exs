defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.codepoints
    |> encode_helper([])
    |> Enum.reverse
    |> make_string
  end

  defp encode_helper([], gl_list), do: gl_list
  defp encode_helper([head|tail], []), do: encode_helper(tail, [{head, 1}])
  defp encode_helper([head|tail], gl = [{letter, frequency}|gl_tail]) do
    cond do
      head == letter -> encode_helper(tail,[{letter, frequency + 1}|gl_tail])
      true -> encode_helper(tail,[{head, 1}|gl])
    end
  end

  defp make_string(list) do
    list
    |> Enum.reduce("", fn {l,f},acc ->
      cond do
        f > 1 -> acc<>to_string(f)<>l
        true -> acc<>l
      end
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    decode_helper(String.codepoints(string),"","")
  end

  defp decode_helper([], "", ""), do: ""
  defp decode_helper([], frequency, decoded), do: decoded
  defp decode_helper([head|tail], frequency, decoded) do
    cond do
      is_numeric?(head) -> decode_helper(tail,frequency<>head, decoded)
      true -> decode_helper(tail,"",decoded<>message_builder(head,frequency))
    end
  end

  defp is_numeric?(char) do
    case Integer.parse(char) do
      {number, ""} -> true
      :error -> false
    end
  end

  defp message_builder(char,frequency) do
    cond do
      frequency == "" -> char
      true -> String.duplicate(char,String.to_integer(frequency))
    end
  end

end
