require_relative 'gamer'

class Dealer < Gamer
  DEALER_CARDS_SUM = 17
  DEALER_NAME = 'Dealer'.freeze
  MAX_CARDS_IN_DECK = 3

  def initialize
    super
    @name = DEALER_NAME
  end

  def miss_turn?
    cards_sum >= DEALER_CARDS_SUM || cards_num >= MAX_CARDS_IN_GAMER_DECK
  end
end
