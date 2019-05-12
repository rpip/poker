# Poker

A Poker deck library

```shell
iex> Poker.ranking(~w[2S 3S 4S 5S 6S])
:straight_flush
iex> Poker.rank(black: ~w(3H 3D 3S 9C KD), white: ~w(2C 3H 4S 8C AH))
Black wins - three of a kind
```

## How it works

Watch this video on how to play Poker.

[How to Play Poker - Basics](https://www.youtube.com/watch?v=xfqMC3G37VE)

## Ranking algorithms

* straight flush - - Straight flush: any five cards in sequence of the same suit. e.g: 6S, 7S, 8S, 9S, 10S. TIE: In this case, the player with the highest card wins
* four of a kind - four cards of the same rank, such as four kings. Also called quads
* full house - three cards of one rank plus two cards of another rank. Called Jacks Full of Nines
* flush - five cards of the same suit (but not a straight flush)
* straight - any five numbered cards in sequence, that are not of the same suit.
* three of a kind - 3 cards of the same number, and the other two don’t match each other. Also called trip
* two pairs - Out of five cards, you have two pairs
* pair - out of five cards you have 1 pair
* high card - none of the above

Each algorithm has an associated tie breaker implemented in Elixir for breaking ties.

See `./lib/poker/tie_breaker/`

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `poker` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:poker, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/poker](https://hexdocs.pm/poker).
