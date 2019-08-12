defmodule BattleshipsArmadaTest do
  use ExUnit.Case
  doctest BattleshipsArmada
  alias BattleshipsArmada.Core.GameState

  test "test length of ships" do
    assert GameState.get_ship_length(2) == 2
    assert GameState.get_ship_length(3) == 3
    assert GameState.get_ship_length(4) == 3
    assert GameState.get_ship_length(5) == 4
    assert GameState.get_ship_length(6) == 5
  end
end
