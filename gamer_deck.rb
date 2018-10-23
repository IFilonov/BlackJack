require_relative 'deck'

class GamerDeck < Deck

  def add_cards(cards)
    @cards += cards if @cards.size + cards.size <= MAX_CARDS_IN_GAMER_DECK
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

  def full?
    @cards.size == MAX_CARDS_IN_GAMER_DECK
  end
end
