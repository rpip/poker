defmodule Poker.Card do
  @moduledoc "A playing card that has rank and suit."

  @type t :: %__MODULE__{}

  defstruct [:rank, :suit]

  defimpl String.Chars do
    def to_string(card) do
      "#{card.rank}#{card.suit}"
    end
  end
end
