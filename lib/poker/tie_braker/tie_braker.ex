defmodule Poker.Hand.TieBraker do
  @moduledoc """
  Implements strategies for breaking ties
  """
  defmacro __using__(_opts) do
    quote do
      import Poker.Hand, only: [ranks: 1, pprint_rank: 1, pairs: 2]
    end
  end

  def resolve(:high_card, black, white) do
    Poker.TieBraker.HighCardResolver.resolve(black, white)
  end

  def resolve(:pair, black, white) do
    Poker.TieBraker.HighCardResolver.resolve(black, white)
  end

  def resolve(:two_pairs, black, white) do
    Poker.TieBraker.TwoPairsResolver.resolve(black, white)
  end

  def resolve(:three_of_a_kind, black, white) do
    Poker.TieBraker.ThreeOfAKindResolver.resolve(black, white)
  end

  def resolve(:straight, black, white) do
    Poker.TieBraker.StraightResolver.resolve(black, white)
  end

  # Hands which are both flushes are ranked using the rules for High Card.
  def resolve(:flush, black, white) do
    Poker.TieBraker.HighCardResolver.resolve(black, white)
  end

  def resolve(:full_house, black, white) do
    Poker.TieBraker.ThreeOfAKindResolver.resolve(black, white)
  end

  # also ranked by the value of the 3 pair cards
  def resolve(:four_of_a_kind, black, white) do
    Poker.TieBraker.FourOfAKindResolver.resolve(black, white)
  end

  def resolve(:straight_flush, black, white) do
    Poker.TieBraker.StraightFlushResolver.resolve(black, white)
  end
end

defmodule Poker.TieBraker.Resolver do
  @moduledoc """
  Behaviour for implementing tie breaking strategies for poker cards
  """

  @callback resolve(black :: Card.t(), white :: Card.t()) ::
              {:black, tie_breaker :: term} | {:white, tie_breaker :: term} | :tie
end
