defmodule Poker.HandTest do
  use ExUnit.Case
  doctest Poker.Hand

  test "high card" do
    assert Poker.ranking(~w[2C 3H 4S 8C AH]) == :high_card
    assert Poker.ranking(~w[2H 3D 5S 9C KD]) == :high_card
  end

  test "flush" do
    assert Poker.ranking(~w[2S 8S AS QS 3S]) == :flush
    assert Poker.ranking(~w[5H 5H 7H 2H 2H]) == :flush
  end

  test "four of a kind" do
    assert Poker.ranking(~w[5H 5S 5D 5C 2D]) == :four_of_a_kind
  end

  test "straight flush" do
    assert Poker.ranking(~w[2S 3S 4S 5S 6S]) == :straight_flush
  end

  test "straight" do
    assert Poker.ranking(~w[2H 3H 4C 5H 6D]) == :straight
  end

  test "full house" do
    assert Poker.ranking(~w[5H 5S 5D 2C 2D]) == :full_house
  end

  test "three of a kind" do
    assert Poker.ranking(~w[2H 7H 3C 3H 3D]) == :three_of_a_kind
  end

  test "two pairs" do
    assert Poker.ranking(~w[3H 3H 5C 2H 5D]) == :two_pairs
  end

  test "pair" do
    assert Poker.ranking(~w[3H 3H 5C 9H 7D]) == :pair
  end
end
