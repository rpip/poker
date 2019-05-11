defmodule Poker.Hand.TieBrakerTest do
  use ExUnit.Case

  def test "high cards ties" do
    hands = [
      black: ~w[2C 3H 4S 8C AH],
      white: ~w[2H 3D 5S 9C KD]
    ]

    assert Poker.rank(hands) == "Black wins - high card: Ace"
  end

  test "two pairs tie" do
    hands = [
      black: ~w[3H 3H 5C 2H 5D],
      white: ~w[3H 3H 6C 4H 6D]
    ]

    assert Poker.rank(hands) == "White wins - two pairs: 6"
  end

  test "three of a kind ties" do
    hands = [
      black: ~w[2H 7H 3C 3H 3D],
      white: ~w[5S 7S 4C 4S 4D]
    ]

    assert Poker.rank(hands) == "White wins - three of a kind: Queen"
  end

  test "flush tie" do
    hands = [
      black: ~w[2S 8S AS QS 3S],
      white: ~w[5H 5H 7H 2H 2H]
    ]

    assert Poker.rank(hands) == "Black wins - flush: 3"
  end
end
