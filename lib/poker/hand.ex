defmodule Poker.Hand do
  @moduledoc """
  An ordered collection of cards.
  """
  alias Poker.TieBreaker

  @type player :: :black | :white

  @type tie_break_value :: term()

  @type ranking ::
          :high_card
          | :pair
          | :two_pairs
          | :three_of_a_kind
          | :straight
          | :flush
          | :full_house
          | :four_of_a_kind
          | :straight_flush

  # Hand ranks
  @rankings %{
    :high_card => 1,
    :pair => 2,
    :two_pairs => 3,
    :three_of_a_kind => 4,
    :straight => 5,
    :flush => 6,
    :full_house => 7,
    :four_of_a_kind => 8,
    :straight_flush => 9
  }

  @doc """
  Evaluates the cards and assigns a rank based on the Poker rules.
  """
  @spec evaluate([Card.t()]) :: ranking
  def evaluate(cards) do
    cond do
      straight_flush?(cards) ->
        :straight_flush

      four_of_a_kind?(cards) ->
        :four_of_a_kind

      full_house?(cards) ->
        :full_house

      flush?(cards) ->
        :flush

      straight?(cards) ->
        :straight

      three_of_a_kind?(cards) ->
        :three_of_a_kind

      two_pairs?(cards) ->
        :two_pairs

      pair?(cards) ->
        :pair

      # Hands which do not fit any higher category
      true ->
        :high_card
    end
  end

  @doc """
  Compares the cards and resolves tie breakes, indicating if any, the tie breaker.
  """
  @spec compare(Card.t(), Card.t()) ::
          {player, ranking} | {player, ranking, tie_break_value} | :tie
  def compare(black, white) do
    black_ranking = evaluate(black)
    white_ranking = evaluate(white)

    cond do
      @rankings[black_ranking] > @rankings[white_ranking] ->
        {:black, black_ranking}

      @rankings[black_ranking] < @rankings[white_ranking] ->
        {:white, white_ranking}

      true ->
        case TieBreaker.resolve(black_ranking, black, white) do
          {player, tie_break_value} ->
            {player, black_ranking, tie_break_value}

          _ ->
            :tie
        end
    end
  end

  @doc """
  Pair

  2 of the 5 cards in the hand have the same value.
  """
  def pair?(cards), do: count_pairs(cards, 2) == 1

  @doc """
  Two Pairs

  The hand contains 2 different pairs.
  """
  def two_pairs?(cards), do: count_pairs(cards, 2) == 2

  @doc """
  Three of a Kind

  Three of the cards in the hand have the same value.
  """
  def three_of_a_kind?(cards), do: count_pairs(cards, 3) == 1

  @doc """
  Straight

  Hand contains 5 cards with consecutive values.
  """
  def straight?(cards) do
    ranks(cards)
    |> Enum.sort()
    |> sequence?
  end

  @doc """
  Flush

  Hand contains 5 cards of the same suit.
  Hands which are both flushes are ranked using the rules for High Card.
  """
  def flush?(cards), do: suits(cards) |> Enum.uniq() |> length == 1

  @doc """
  Full House
  3 cards of the same value, with the remaining 2 cards forming a pair.

  Ranked by the value of the 3 cards.
  """
  def full_house?(cards), do: count_pairs(cards, 3) == 1 && count_pairs(cards, 2) == 1

  @doc """
  Four of a kind

  4 cards with the same value. Ranked by the value of the 4 cards.
  """
  def four_of_a_kind?(cards), do: count_pairs(cards, 4) == 1

  @doc """
  Straight flush

  5 cards of the same suit with consecutive values.
  Ranked by the highest card in the hand.
  """
  def straight_flush?(cards), do: flush?(cards) && straight?(cards)

  def pairs(cards, pair_size) do
    values = ranks(cards)

    Enum.filter(values, fn fe -> Enum.count(values, &(&1 == fe)) == pair_size end)
  end

  def suits(cards), do: Enum.map(cards, & &1.suit)

  def ranks(cards), do: Enum.map(cards, & &1.rank)

  def pprint_rank(10), do: "T"
  def pprint_rank(11), do: "Jacl"
  def pprint_rank(12), do: "Queen"
  def pprint_rank(13), do: "King"
  def pprint_rank(14), do: "Ace"
  def pprint_rank(rank), do: rank

  ## private methods

  defp count_pairs(cards, pair_size) do
    pairs(cards, pair_size)
    |> Enum.uniq()
    |> Enum.count()
  end

  defp sequence?([cur | [next | rest]]) do
    next - cur == 1 && sequence?([next | rest])
  end

  defp sequence?(_), do: true
end
