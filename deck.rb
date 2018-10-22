require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
  end

  def cards_name
    names = []
    @cards.each { |card| names << card.name }
    names
  end

  def flush
    @cards = []
  end
end
