class Interface

  START_MENU = [
    'Continue game'
  ].freeze

  GAME_MENU = [
    'Skip the game',
    'Add card',
    'Show cards'
  ].freeze

  QUIT_MENU = 'q'.freeze

  def initialize
    puts 'Black Jack'
  end

  def input
    gets.chomp.to_s
  end

  def break(menu_item)
    menu_item == QUIT_MENU
  end

  def show_start_menu
    show_menu(START_MENU)
    input
  end

  def show_game_menu
    show_menu(GAME_MENU)
    input
  end

  def show_menu(menu)
    puts "Enter number to select menu item or type #{QUIT_MENU} to exit:"
    menu.each_with_index { |value, index| puts "#{index} - #{value}" }
  end

  def ask_name
    puts 'Enter Gamer name:'
  end

  def dealer_miss_turn
    puts 'Dealer missed a turn'
  end

  def dealer_add_card
    puts 'Dealer added a card'
  end

  def err_three_cards
    'You cannot add more than 3 cards!'
  end

  def show_cards(gamer, hide = false)
    print "#{gamer.name}! "
    puts "Sum cards: #{hide ? '***' : gamer.deck.sum}, cards:"
    gamer.cards_name.each { |name| puts hide ? '***' : name }
  end

  def show_finish_bank(gamer_name, dealer_name, bank)
    print "Gamer #{gamer_name} bank: #{bank.gamer_money}, "
    puts "#{dealer_name} bank: #{bank.dealer_money}"
  end

  def bank_empty_game_over
    puts "Bank empty! Game over! Type q to exit"
    QUIT_MENU
  end

  def draw
    puts 'DRAW!'
  end

  def no_wins
    puts 'NO WINS!'
  end

  def dealer_win
    puts 'Dealer WIN!'
  end

  def gamer_win
    puts 'Gamer WIN!'
  end
end

