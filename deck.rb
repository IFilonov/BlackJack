require_relative 'card'

class Deck
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
