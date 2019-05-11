defmodule Poker.TieBreaker.TwoPairsResolver do
  @moduledoc """
  Hands which both contain 2 pairs are ranked by the value
  of their highest pair. Hands with the same highest pair are
  ranked by the value of their other pair. If these values are
  the same the hands are ranked by the value of the remaining card.
  """
  @behaviour Poker.TieBreaker.Resolver

  use Poker.TieBreaker

  def resolve(black, white) do
    with black_pairs <- pairs(black, 2),
         white_pairs <- pairs(white, 2),
         max_black <- Enum.max(black_pairs),
         max_white <- Enum.max(white_pairs),
         min_black <- Enum.min(black_pairs),
         min_white <- Enum.min(white_pairs) do
      cond do
        max_black > max_white ->
          {:black, pprint_rank(max_black)}

        max_black < max_white ->
          {:white, pprint_rank(max_white)}

        true ->
          # rank by other pair, min pair
          cond do
            min_black > min_white ->
              {:black, pprint_rank(min_black)}

            min_black < min_white ->
              {:white, pprint_rank(min_white)}

            true ->
              # rank by the value of the remaining card
              [b_rank | _] = ranks(black) -- black_pairs
              [w_rank | _] = ranks(white) -- white_pairs

              cond do
                b_rank > w_rank ->
                  {:black, pprint_rank(b_rank)}

                b_rank < w_rank ->
                  {:white, pprint_rank(w_rank)}

                true ->
                  :tie
              end
          end
      end
    end
  end
end
