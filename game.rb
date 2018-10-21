require_relative 'gamer'
require_relative 'game_pack'
require_relative 'bank'
require_relative 'game_process'

class Game
  include GameProcess

  def initialize
    puts 'Black Jack'
    @bank = Bank.new
    @game_pack = GamePack.new
    @dealer = Gamer.new('Dealer')
  end

  def main
    puts 'Enter Gamer name:'
    name = gets.chomp
    @gamer = Gamer.new(name)
    show_start_menu = false
    loop do
      if show_start_menu
        show_menu(START_MENU)
        menu_item = gets.chomp.to_s
      end
      break if menu_item == QUIT_MENU

      call_item_handler(START_MENU, menu_item)
      show_start_menu = true
    end
  end

  private

  def show_menu(menu)
    puts "Enter number to select menu item or type #{QUIT_MENU} to exit:"
    menu.each_with_index { |value, index| puts "#{index} - #{value[:label]}" }
  end

  def call_item_handler(menu, item)
    item = '0' if item.nil?
    send(menu[item.to_i][:handler]) if menu[item.to_i] && number?(item)
    menu[item.to_i][:exit_loop]
  end

  def number?(number_str)
    number_str.to_i.to_s == number_str
  end
end

g = Game.new
g.main
