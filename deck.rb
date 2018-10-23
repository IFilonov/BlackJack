require_relative 'card'

class Deck
  MAX_CARDS_IN_GAMER_DECK = 3

  attr_reader :cards

  def initialize
    @cards = []
  end

  def cards_name
    @cards.map(&:name)
  end

  def flush
    @cards = []
  end
end
