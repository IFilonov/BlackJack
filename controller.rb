require_relative 'interface'

class Controller
  START_MENU = [
    { handler: :process_game, exit_loop: false }
  ].freeze

  GAME_MENU = [
    { handler: :skip_the_game, exit_loop: false },
    { handler: :add_cards, exit_loop: false },
    { handler: :show_and_finish_game, exit_loop: true }
  ].freeze

  BJ_SUM = 21

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
    show_start_menu = false
    loop do
      if show_start_menu
        menu_item = if @bank.enough_money_for_game?
                      @interface.show_start_menu
                    else
                      @interface.bank_empty_game_over
                    end
      end
      break if @interface.break(menu_item)

      call_item_handler(START_MENU, menu_item)
      show_start_menu = true
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
        break if @interface.break(item) || call_item_handler(GAME_MENU, item)

        if @dealer.deck_full? && @gamer.deck_full?
          show_and_finish_game
          return
        end
      rescue RuntimeError => e
        puts e
      end
    end
  end

  def skip_the_game
    if @dealer.miss_turn?
      @interface.dealer_miss_turn
    else
      @dealer.add_cards(@game_deck.get_cards(1))
      @interface.dealer_add_card
      @interface.show_cards(@gamer, @dealer)
    end
  end

  def add_cards
    raise @interface.err_three_cards if @gamer.cards_num >= 3

    @gamer.add_cards(@game_deck.get_cards(1))
    @interface.show_cards(@gamer, @dealer)
  end

  def show_and_finish_game
    @interface.show_cards(@gamer, @dealer, true)
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
    @interface.show_finish_bank(@gamer.name, @dealer.name, @bank)
    flush_gamers_cards
  end

  def flush_gamers_cards
    @dealer.deck.flush
    @gamer.deck.flush
    @game_deck.flush
  end

  def call_item_handler(menu, item)
    item = '0' if item.nil?
    return unless menu[item.to_i] && number?(item)

    send(menu[item.to_i][:handler])
    menu[item.to_i][:exit_loop]
  end

  def number?(number_str)
    number_str.to_i.to_s == number_str
  end
end
