require_relative 'gamer'

class Dealer < Gamer
  DEALER_CARDS_SUM = 17
  DEALER_NAME = 'Dealer'.freeze

  def initialize
    super
    @name = DEALER_NAME
  end

  def miss_turn?
    cards_sum >= DEALER_CARDS_SUM
  end
end
