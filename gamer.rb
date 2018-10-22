require_relative 'gamer_deck'

class Gamer
  attr_accessor :name
  attr_accessor :deck

  def initialize
    @deck = GamerDeck.new
  end

  def cards_name
    @deck.cards_name
  end

  def cards_sum
    @deck.sum
  end

  def cards_num
    @deck.cards.size
  end

  def add_cards(cards)
    @deck.add_cards(cards)
  end

  def deck_full?
    @deck.full?
  end
end
