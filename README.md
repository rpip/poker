# Poker

A Poker deck library

## How it works

Watch this video on how to play Poker.

[How to Play Poker - Basics](https://www.youtube.com/watch?v=xfqMC3G37VE)

## Ranking algorithms

* straight flush - - Straight flush: any five cards in sequence of the same suit. e.g: 6S, 7S, 8S, 9S, 10S. TIE: In this case, the player with the highest card wins
* four of a kind - four cards of the same rank, such as four kings. Also called quads
* full house - three cards of one rank plus two cards of another rank. Called Jacks Full of Nines
* flush - five cards of the same suit (but not a straight flush)
* straight - five cards in order - just like the straight flush, but mixed suits
* three of a kind - three cards of one rank and two other cards
* two pairs - two cards of one rank, two cards of another rank, and one more card
* pair - two cards of the same rank
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
