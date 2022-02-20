defmodule Cards do
  @spec create_deck :: list
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    cards = for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
    List.flatten(cards)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  #pattern matching
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
      # name with underscore in the head => we know but we dont care it
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains(deck, card) do
    Enum.member?(deck, card)
  end

  #pipe operator
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)

  end


end
