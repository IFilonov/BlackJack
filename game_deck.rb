require_relative 'deck'

class GameDeck < Deck
  def initialize
    super
    fill_cards
  end

  def fill_cards
    Card::TYPES.each do |type|
      Card::NUMBERS.each { |number| @cards.push(Card.new(number, type)) }
    end
    @cards.shuffle!
  end

  def get_cards(count)
    @cards.pop(count) if @cards.size > count
  end

  def flush
    super
    fill_cards
  end
end
