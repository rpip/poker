defmodule Poker do
  @moduledoc """
  A poker deck contains 52 cards - each card has a suit which is one
  of clubs, diamonds, hearts, or spades (denoted C, D, H, and S in the
  input data).

  Each card also has a value which is one of 2, 3, 4, 5,
  6, 7, 8, 9, 10, jack, queen, king, ace (denoted 2, 3, 4, 5, 6, 7, 8,
  9, T, J, Q, K, A).

  For scoring purposes, the suits are unordered
  while the values are ordered as given above, with 2 being the lowest
  and ace the highest value.

  A poker hand consists of 5 cards dealt from the deck. Poker handsare
  ranked by the following partial order from lowest to highest.
  """
  alias Poker.{Card, Hand, InvalidCardError}

  # in ascending order. T = 10, J = Jack/11, Q = Queen/12, K = King/13, A = Ace/14
  @ranks ~w[2 3 4 5 6 7 8 9 T J Q K A]

  # suits are unordered. Clubs, Diamonds, Hearts, Spades
  @suits ~w[C D H S]

  @hand_size 5

  @doc """
  Given a pair of poker hands, ranks them and indicates which, if either, has a higher rank.

  ## Examples

      iex> Poker.rank(black: ~w[2H 3D 5S 9C KD], white: ~w[2C 3H 4S 8C AH])
      "White wins - high card: Ace"

      iex> Poker.rank(black: ~w[2H 4S 4C 3D 4H], white: ~w[2S 8S AS QS 3S])
      "White wins - flush"

      iex> Poker.rank(black: ~w[2H 4S 4C 3D 4H], white: ~w[2S 8S AS QS 3S])
      "White wins - flush"

      iex> Poker.rank(black: ~w[2H 3D 5S 9C KD], white: ~w[2C 3H 4S 8C KH])
      "Black wins - high card: 9"

      iex> Poker.rank(black: ~w[2H 3D 5S 9C KD], white: ~w[2D 3H 5C 9S KH])
      "Tie"
  """
  def rank(black: black, white: white) do
    # parse hands -> detect hand type -> rank hands -> print result
    with {:ok, black_hand} <- parse_hand!(black),
         {:ok, white_hand} <- parse_hand!(white) do
      case Hand.compare(black_hand, white_hand) do
        {player, ranking} ->
          "#{String.capitalize(to_string(player))} wins - #{unslugify(ranking)}"

        {player, ranking, tie_breaker} ->
          # TODO: unslugify ranking, e.g: high_card -> high_card
          "#{String.capitalize(to_string(player))} wins - #{unslugify(ranking)}: #{tie_breaker}"

        :tie ->
          "Tie"
      end
    end
  end

  def rank(black, white) do
    rank(black: black, white: white)
  end

  @doc "Returns the ranking of the hand"
  def ranking(string) do
    with {:ok, cards} <- parse_hand!(string) do
      Poker.Hand.evaluate(cards)
    end
  end

  @doc """
  Parses a list of strings into Poker card structs

      iex> Poker.parse_hand!(~w[2H 3D 5S 9C KD])
      {:ok, [
      %Poker.Card{rank: 2, suit: "H"},
      %Poker.Card{rank: 3, suit: "D"},
      %Poker.Card{rank: 5, suit: "S"},
      %Poker.Card{rank: 9, suit: "C"},
      %Poker.Card{rank: 13, suit: "D"}
      ]}
  """
  def parse_hand!([]) do
    {:error, {:invalid_handsize, [expected: @hand_size, got: nil]}}
  end

  def parse_hand!(hand) when length(hand) != @hand_size do
    {:error, {:invalid_handsize, [expected: @hand_size, got: length(hand)]}}
  end

  def parse_hand!(hand) do
    cards =
      for card_str <- hand do
        [rank, suit] = card = String.split(card_str, "", trim: true)
        validate_card!(card)
        %Card{rank: rank_to_int(rank), suit: suit}
      end

    {:ok, cards}
  end

  defp rank_to_int("T"), do: 10
  defp rank_to_int("J"), do: 11
  defp rank_to_int("Q"), do: 12
  defp rank_to_int("K"), do: 13
  defp rank_to_int("A"), do: 14

  defp rank_to_int(rank), do: String.to_integer(rank)

  defp unslugify(ranking) do
    to_string(ranking) |> String.split("_") |> Enum.join(" ")
  end

  defp validate_card!([rank, suit] = card) do
    if rank not in @ranks,
      do: raise(InvalidCardError, card: "#{card}", expected: @ranks, got: rank)

    if suit not in @suits,
      do: raise(InvalidCardError, card: "#{card}", expected: @suits, got: suit)
  end
end

defmodule Poker.InvalidCardError do
  defexception card: nil, expected: nil, got: nil

  def message(exception) do
    """
    Invalid card: #{exception.card}
    Expected one of #{exception.expected}, got #{exception.got}
    """
  end
end
