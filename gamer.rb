require_relative 'deck'

class Gamer
  attr_accessor :name
  attr_accessor :deck

  def initialize(name)
    @deck = Deck.new
    @name = name.capitalize
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
end
