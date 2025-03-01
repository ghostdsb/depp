defmodule Roman do
  @romaneq [1000,900,500,400,100,90,50,40,10,9,5,4,1]
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(1000), do: "M"
  def numerals(900), do: "CM"
  def numerals(500), do: "D"
  def numerals(400), do: "CD"
  def numerals(100), do: "C"
  def numerals(90), do: "XC"
  def numerals(50), do: "L"
  def numerals(40), do: "XL"
  def numerals(10), do: "X"
  def numerals(9), do: "IX"
  def numerals(5), do: "V"
  def numerals(4), do: "IV"
  def numerals(1), do: "I"
  def numerals(number), do: numerals(0,Enum.at(@romaneq, 0),number,"")
  defp numerals(_,_,0,string), do: string
  defp numerals(id, x,number, string) do
    numerals(
      id+1,
      Enum.at(@romaneq, id+1),
      number-(div(number,x)*x),
      string<>String.duplicate(numerals(x),div(number,x))
    )
  end
end
