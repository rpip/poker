defmodule Poker.TieBraker.PairResolver do
  @moduledoc """
  Hands which both contain a pair are ranked by the value
  of the cards forming the pair. If these values are the same,
  the hands are ranked by the values of the cards not forming
  the pair, in decreasing order.
  """
  @behaviour Poker.TieBraker.Resolver

  use Poker.Hand.TieBraker

  def resolve(black, white) do
    black_total = Enum.sum(pairs(black, 2))
    white_total = Enum.sum(pairs(white, 2))

    cond do
      black_total > white_total ->
        {:black, pprint_rank(black_total)}

      black_total < white_total ->
        {:white, pprint_rank(white_total)}

      true ->
        with b_ranks <- ranks(black),
             w_ranks <- ranks(white) do
          black_total = Enum.sum(Enum.filter(b_ranks, fn x -> x not in pairs(black, 2) end))
          white_total = Enum.sum(Enum.filter(w_ranks, fn x -> x not in pairs(white, 2) end))

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
  end
end
