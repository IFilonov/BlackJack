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

  def flush
    super
    fill_cards
  end
end
