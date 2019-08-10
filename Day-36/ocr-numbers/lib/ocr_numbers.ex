defmodule OcrNumbers do
  @zero [
    " _ ",
    "| |",
    "|_|",
    "   "
  ]

  @one [
    "   ",
    "  |",
    "  |",
    "   "
  ]

  @two [
    " _ ",
    " _|",
    "|_ ",
    "   "
  ]

  @three [
    " _ ",
    " _|",
    " _|",
    "   "
  ]

  @four [
    "   ",
    "|_|",
    "  |",
    "   "
  ]

  @five [
    " _ ",
    "|_ ",
    " _|",
    "   "
  ]

  @six [
    " _ ",
    "|_ ",
    "|_|",
    "   "
  ]

  @seven [
    " _ ",
    "  |",
    "  |",
    "   "
  ]

  @eight [
    " _ ",
    "|_|",
    "|_|",
    "   "
  ]

  @nine [
    " _ ",
    "|_|",
    " _|",
    "   "
  ]

  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: String.t()
  def convert(input) do
    cond do
      not valid_row?(input) -> {:error, 'invalid line count'}
      not valid_col?(input) -> {:error, 'invalid column count'}
      true -> parser(input)
    end
  end
  def parser(input) do
    input
    |> hd
    |> String.length
    |> (&(0..div(&1,3)-1)).()
    |> Enum.map(&(window(&1*3,input,[])))
    |> Enum.map(fn x -> Enum.map(x, &(single_digit(&1))) end)
    |> transpose
    |> Enum.map(&(Enum.reduce(&1,"",fn x,acc -> acc<>x end)))
    |> Enum.join(",")
    |> printer
  end

  def window(_,[], list), do: Enum.reverse(list)
  def window(start,[a,b,c,d|t], list) do
    running_list = [a,b,c,d]
    |> Enum.reduce([], fn x,acc -> [String.slice(x,start..(start+2))|acc] end)
    |> Enum.reverse
    window(start, t, [running_list|list])
  end

  defp single_digit(@zero), do: "0"
  defp single_digit(@one), do: "1"
  defp single_digit(@two), do: "2"
  defp single_digit(@three), do: "3"
  defp single_digit(@four), do: "4"
  defp single_digit(@five), do: "5"
  defp single_digit(@six), do: "6"
  defp single_digit(@seven), do: "7"
  defp single_digit(@eight), do: "8"
  defp single_digit(@nine), do: "9"
  defp single_digit(_), do: "?"

  defp valid_row?(ocr), do: rem(length(ocr),4) === 0

  defp valid_col?(ocr) do
    ocr
    |> Enum.any?(fn x-> rem(String.length(x),3) !== 0 end)
    |> (&(!&1)).()
  end

  def transpose([]), do: []
  def transpose([[]|_]), do: []
  def transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end

  defp printer(value), do: {:ok, value}
end
