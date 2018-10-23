require_relative 'interface'

class Controller
  START_MENU_HANDLERS = [
    { handler: :process_game }
  ].freeze

  GAME_MENU_HANLDERS = [
    { handler: :dealer_game },
    { handler: :gamer_add_cards },
    { handler: :finish_game }
  ].freeze

  BJ_SUM = 21
  BREAK_LOOP = true
  INCORRECT_CHOICE = false
  HIDE_DEALER_CARDS = true

  def initialize(gamer, dealer, bank, game_deck)
    @gamer = gamer
    @dealer = dealer
    @bank = bank
    @game_deck = game_deck
    @interface = Interface.new
  end

  def main
    @interface.ask_gamer_name
    @gamer.name = @interface.input
    loop do
      return @interface.game_over unless @bank.enough_money_for_game?

      menu_item = @interface.show_start_menu
      call_item_handler(START_MENU_HANDLERS, menu_item)
      break if @exit_loop
    end
  end

  private

  def prepare_new_game
    @gamer.add_cards(@game_deck.get_cards(2))
    @dealer.add_cards(@game_deck.get_cards(2))
    @interface.show_cards(@gamer, @dealer)
    @bank.charge_game
  end

  def process_game
    prepare_new_game
    loop do
      begin
        item = @interface.show_game_menu
        call_item_handler(GAME_MENU_HANLDERS, item)
        break if @exit_loop
      rescue RuntimeError => e
        puts e
      end
    end
    @exit_loop = false
  end

  def dealer_game
    if @dealer.miss_turn?
      @interface.dealer_miss_turn
    else
      @dealer.add_cards(@game_deck.get_cards(1))
      @interface.dealer_add_card
      return @interface.show_cards(@gamer, @dealer) unless check_cards(@dealer)

      finish_game
    end
  end

  def check_cards(gamer)
    gamer.cards_sum > BJ_SUM || (@dealer.deck_full? && @gamer.deck_full?)
  end

  def gamer_add_cards
    raise @interface.err_three_cards if @gamer.cards_num >= 3

    @gamer.add_cards(@game_deck.get_cards(1))
    return @interface.show_cards(@gamer, @dealer) unless check_cards(@gamer)

    finish_game
  end

  def finish_game
    gamer_sum = @gamer.cards_sum
    dealer_sum = @dealer.cards_sum
    if gamer_sum == dealer_sum
      @interface.draw
      @bank.rollback
    elsif gamer_sum > BJ_SUM && dealer_sum > BJ_SUM
      @interface.no_wins
    elsif (gamer_sum > BJ_SUM || gamer_sum < dealer_sum) && dealer_sum <= BJ_SUM
      @bank.dealer_win
      @interface.dealer_win
    else
      @bank.gamer_win
      @interface.gamer_win
    end
    show_gamers_cards
  end

  def show_gamers_cards
    @interface.show_cards(@gamer, @dealer, HIDE_DEALER_CARDS)
    @interface.show_finish_bank(@gamer.name, @dealer.name, @bank)
    @dealer.deck.flush
    @gamer.deck.flush
    @game_deck.flush
    @exit_loop = BREAK_LOOP
  end

  def call_item_handler(menu, item)
    return @exit_loop = BREAK_LOOP if @interface.break_menu?(item)
    return @exit_loop = INCORRECT_CHOICE unless menu[item.to_i] && number?(item)

    send(menu[item.to_i][:handler])
  end

  def number?(number_str)
    number_str.to_i.to_s == number_str
  end
end
