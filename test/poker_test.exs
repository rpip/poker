defmodule PokerTest do
  use ExUnit.Case
  doctest Poker

  test "parse string of cards" do
    assert Poker.parse_hand!(~w(3H 3D 3S 9C KD)) ==
             {:ok,
              [
                %Poker.Card{rank: 3, suit: "H"},
                %Poker.Card{rank: 3, suit: "D"},
                %Poker.Card{rank: 3, suit: "S"},
                %Poker.Card{rank: 9, suit: "C"},
                %Poker.Card{rank: 13, suit: "D"}
              ]}
  end

  test "ranks the two hands" do
    three_of_a_kind = ~w(3H 3D 3S 9C KD)
    high_card = ~w(2C 3H 4S 8C AH)

    hands = [
      black: three_of_a_kind,
      white: high_card
    ]

    assert Poker.rank(hands) == "Black wins - three of a kind"
  end

  test "raises invalid card error" do
    assert_raise(Poker.InvalidCardError, fn ->
      Poker.parse_hand!(~w(2P 8C KD 3H 4S))
    end)
  end
end
