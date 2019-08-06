# Dilemma

Chef has no work to do in the kitchen, so he decided to play a card game with the following rules:

Initially, N cards are placed in a row on a table. Each card is placed either face up or face down.
The goal of the game is to remove all cards from the table, one by one.
A card may be removed only if it is currently facing up.
When a card is removed, its adjacent cards (the cards directly to its left and right, if they exist) are flipped, i.e. a card that was facing up will be facing down and vice versa.
There is an empty space left behind each removed card, i.e. the remaining cards are not moved to create a contiguous row of cards again. Therefore, if the game starts with three cards and the middle card is removed, then the cards on the sides are flipped, but removing one of these cards afterwards does not cause the other card to be flipped, since it is only adjacent to the empty space created by removing the middle card.
Determine whether Chef is able to win this game.



## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `dilemma` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:dilemma, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/dilemma](https://hexdocs.pm/dilemma).

