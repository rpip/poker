defmodule Poker.TieBreaker.HighCardResolver do
  @moduledoc """
  Hands which do not fit any higher category are ranked
  by the value of their highest card. If the highest
  cards have the same value, the hands are ranked by the
  next highest, and so on.
  """
  @behaviour Poker.TieBreaker.Resolver

  use Poker.TieBreaker

  def resolve(black, white) do
    with black_ranks <- ranks(black) |> Enum.reverse(),
         white_ranks <- ranks(white) |> Enum.reverse() do
      tie_breaker =
        Enum.zip(black_ranks, white_ranks)
        |> Enum.drop_while(fn {b_val, w_val} = _x -> b_val == w_val end)
        |> Enum.at(0)

      if tie_breaker do
        {black_val, white_val} = tie_breaker

        cond do
          black_val > white_val ->
            {:black, pprint_rank(black_val)}

          black_val < white_val ->
            {:white, pprint_rank(white_val)}
        end
      else
        :tie
      end
    end
  end
end
