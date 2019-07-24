defmodule Say do
  @words %{
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }
  
  @hundred " hundred "
  @thousand " thousand "
  @million " million "
  @billion " billion "
  
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(0), do: {:ok, "zero"}
  def in_english(number) when number >= 0 and number <= 999_999_999_999 do
    number
    |> Integer.digits
    |> Enum.reverse
    |> Enum.chunk_every(3) 
    |> Enum.reverse 
    |> Enum.map(fn x -> Enum.reverse(x) end)
    |> Enum.map(fn x -> Enum.join(x) |> String.to_integer |> three_digit_groups end)
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reverse
    |> combiner("")
    |> say
  end
  def in_english(_) , do: {:error, "number is out of range"}

  defp say(word), do: {:ok, String.trim(word)} 

  defp combiner([], word), do: word
  defp combiner([{"zero", _}|t], word), do: combiner(t, word)
  defp combiner([{name, 3}|t], word), do: combiner(t, word<>name<>@billion)
  defp combiner([{name, 2}|t], word), do: combiner(t, word<>name<>@million)
  defp combiner([{name, 1}|t], word), do: combiner(t, word<>name<>@thousand)
  defp combiner([{name, 0}|_], word), do: word<>name

  defp three_digit_helper(number) do
    number |> three_digit_groups
  end

  defp two_digit_group(number) do
    place_value_list = number
    |> Integer.digits
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reverse
    |> Enum.reduce([],fn {k,v},acc -> acc ++ [k*power(10,v)] end)
    cond do
      number < 20 -> @words[number]
      tl(place_value_list) === [0] -> @words[hd(place_value_list)]
      true -> Enum.map(place_value_list,fn x-> @words[x] end) |> Enum.join("-")
    end
  end

  defp three_digit_groups(number) do
    digit_list = number |> Integer.digits
    cond do
      length(digit_list) < 3 -> two_digit_group(rem(number, 100))
      tl(digit_list) === [0,0] -> three_digit_helper(div(number,100)) <> @hundred
      true -> three_digit_helper(div(number,100)) <> @hundred <> three_digit_helper(rem(number, 100))
    end
  end

  defp power(_,0), do: 1
  defp power(n,x), do: power(n,x,1)
  defp power(_,0,p), do: p
  defp power(n,x,p), do: power(n,x-1, n*p)
end