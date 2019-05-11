defmodule Poker.TieBraker.StraightFlushResolver do
  @moduledoc """
  Ranked by the highest card in the hand.
  """
  @behaviour Poker.TieBraker.Resolver

  use Poker.Hand.TieBraker

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
