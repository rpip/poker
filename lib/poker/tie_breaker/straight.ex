defmodule Poker.TieBreaker.StraightResolver do
  @moduledoc """
  Hands which both contain a straight are ranked by their highest card.
  """
  @behaviour Poker.TieBreaker.Resolver

  use Poker.TieBreaker

  def resolve(black, white) do
    black_max = Enum.max(ranks(black))
    white_max = Enum.max(ranks(white))

    cond do
      black_max > white_max ->
        {:black, pprint_rank(black_max)}

      black_max < white_max ->
        {:white, pprint_rank(white_max)}

      true ->
        :tie
    end
  end
end
