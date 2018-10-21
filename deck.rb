require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
  end

  def get_cards(count)
    @cards.pop(count) if @cards.size > count
  end

  def add_cards(cards)
    @cards += cards if @cards.size < 3 && @cards.size + cards.size <= 3
  end

  def cards_name
    names = []
    @cards.each { |card| names << card.name }
    names
  end

  def sum
    values = []
    @cards.each { |card| values << card.value }
    loop do
      break if values.count(Card::ACE_VALUE).zero? || values.sum <= 21

      values.sort!
      values[-1] = 1
    end
    values.sum
  end

  def flush
    @cards = []
  end
end
