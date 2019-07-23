defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0 or number > 99_999_999_999, do: {:error, "number is out of range"}
  def in_english(0), do: "zero"
  def in_english(1), do: "one"
  def in_english(2), do: "two"
  def in_english(3), do: "three"
  def in_english(4), do: "four"
  def in_english(5), do: "five"
  def in_english(6), do: "six"
  def in_english(7), do: "seven"
  def in_english(8), do: "eight"
  def in_english(9), do: "nine"
  def in_english(10), do: "ten"
  def in_english(11), do: "eleven"
  def in_english(12), do: "twelve"
  def in_english(13), do: "thirteen"
  def in_english(14), do: "fourteen"
  def in_english(15), do: "fifteen"
  def in_english(16), do: "sixteen"
  def in_english(17), do: "seventeen"
  def in_english(18), do: "eighteen"
  def in_english(19), do: "nineteen"
  def in_english(20), do: "twenty"
  def in_english(30), do: "thirty"
  def in_english(40), do: "forty"
  def in_english(50), do: "fifty"
  def in_english(60), do: "sixty"
  def in_english(70), do: "seventy"
  def in_english(80), do: "eighty"
  def in_english(90), do: "ninety"
  def in_english(100), do: "hundred"
  def in_english(1_000), do: "thousand"
  def in_english(1_000_000), do: "million"
  def in_english(1_000_000_000), do: "billion"
  def in_english(number) do
    number
    |> three_groups
  end

  defp twos_group(number) do
    number
    |> Integer.digits
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reverse
    |> Enum.reduce([],fn {k,v},acc -> acc ++ [k*power(10,v)] end)
    |> Enum.map(fn x-> in_english(x) end)
    |> Enum.join("-")
  end

  defp three_groups(number) do
    digit_list = number |> Integer.digits
    cond do
      length(digit_list) < 3 -> twos_group(rem(number, 100))
      true -> in_english(div(number,100)) <> " hundred and " <> in_english(rem(number, 100))
    end
  end

  defp power(_,0), do: 1
  defp power(n,x), do: power(n,x,1)
  defp power(_,0,p), do: p
  defp power(n,x,p), do: power(n,x-1, n*p)
end
