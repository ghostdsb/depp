defmodule MathUtilTest do
  use ExUnit.Case
  doctest MathUtil

  test "0!" do
    assert MathUtil.factorial(0) == 1
  end

  test "1!" do
    assert MathUtil.factorial(1) == 1
  end

  test "5!" do
    assert MathUtil.factorial(5) == 120
  end

  test "2^3" do
    assert MathUtil.power(2,3) == 8
  end

  test "12^2" do
    assert MathUtil.power(12,2) == 144
  end

end
