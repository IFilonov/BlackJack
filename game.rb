require_relative 'gamer'
require_relative 'game_deck'
require_relative 'bank'
require_relative 'controller'
require_relative 'dealer'

class Game
  def initialize
    @bank = Bank.new
    @game_deck = GameDeck.new
    @dealer = Dealer.new
    @gamer = Gamer.new
    @controller = Controller.new(@gamer, @dealer, @bank, @game_deck)
  rescue StandardError => e
    puts e
  end

  def main
    @controller.main
  end
end

g = Game.new
g.main
