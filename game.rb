require_relative 'gamer'
require_relative 'game_deck'
require_relative 'bank'
require_relative 'game_process'
require_relative 'interface'

class Game
  include GameProcess

  def initialize
    @interface = Interface.new
    @bank = Bank.new
    @game_deck = GameDeck.new
    @dealer = Gamer.new('Dealer')
  end

  def main
    @interface.ask_name
    name = @interface.input
    @gamer = Gamer.new(name)
    show_start_menu = false
    loop do
      if show_start_menu
        if @bank.enough_money_for_game?
          menu_item = @interface.show_start_menu
        else
          menu_item = @interface.bank_empty_game_over
        end
      end
      break if @interface.break(menu_item)

      call_item_handler(START_MENU, menu_item)
      show_start_menu = true
    end
  end

  private

  def call_item_handler(menu, item)
    item = '0' if item.nil?
    if menu[item.to_i] && number?(item)
      send(menu[item.to_i][:handler])
      menu[item.to_i][:exit_loop]
    end
  end

  def number?(number_str)
    number_str.to_i.to_s == number_str
  end
end

g = Game.new
g.main
