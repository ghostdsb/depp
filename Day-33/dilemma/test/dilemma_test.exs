defmodule DilemmaTest do
  use ExUnit.Case
  doctest Dilemma

  test "case 10" do
    assert Dilemma.solve("10") == "WIN"
  end

  test "case 110010" do
    assert Dilemma.solve("110010") == "WIN"
  end

  test "case 000110010" do
    assert Dilemma.solve("000110010") == "WIN"
  end

  test "case 0001100101" do
    assert Dilemma.solve("0001100101") == "LOSE"
  end
end
