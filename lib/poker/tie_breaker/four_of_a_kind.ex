defmodule Poker.TieBreaker.FourOfAKindResolver do
  @moduledoc """
  Hands which both contain four of a kind are ranked by
  the value of the 4 cards.
  """
  @behaviour Poker.TieBreaker.Resolver

  use Poker.TieBreaker

  def resolve(black, white) do
    black_total = Enum.sum(pairs(black, 4))
    white_total = Enum.sum(pairs(white, 4))

    cond do
      black_total > white_total ->
        {:black, pprint_rank(black_total)}

      black_total < white_total ->
        {:white, pprint_rank(white_total)}

      true ->
        :tie
    end
  end
end
