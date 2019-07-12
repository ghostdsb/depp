defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    raw
    |> String.split(~r/[^\d]/, trim: true)
    |> Enum.join
    |> String.to_charlist
    |> Enum.map(&(String.to_integer(<<&1>>)))
    |> clean(has_letters?(raw))

  end

  defp clean(_,true), do: "0000000000"

  defp clean(filter,_) do
    cond do
      length(filter) > 11 -> "0000000000"
      length(filter) == 11 -> get_number(filter)
      length(filter) == 10 -> get_number([1|filter])
      true -> "0000000000"
    end
  end

  defp get_number(clean_list = [c,a,_,_,x,_,_,_,_,_,_]) do
    cond do
      c != 1 -> "0000000000"
      a < 2 || x < 2 -> "0000000000"
      true -> tl(clean_list) |> Enum.map(&(Integer.to_string(&1))) |> Enum.join
    end
  end

  defp has_letters?(string), do: Enum.any?(String.to_charlist(string), fn x -> x>=65 && x<=91 || x>=97 && x <= 122 end)

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    raw
    |> number
    |> String.slice(0,3)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    clean = raw |> number
    "(#{String.slice(clean, 0,3)}) #{String.slice(clean, 3,3)}-#{String.slice(clean, -4, 4)}"
  end
end
