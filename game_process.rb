require_relative 'game_constants'

module GameProcess
  include GameConstants

  private

  def prepare_new_game
    @gamer.add_cards(@game_deck.get_cards(2))
    @dealer.add_cards(@game_deck.get_cards(2))
    @interface.show_cards(@gamer)
    @interface.show_cards(@dealer, true)
    @bank.charge_game(ONE_GAME_MONEY)
  end

  def process_game
    prepare_new_game
    loop do
      begin
        item = @interface.show_game_menu
        break if @interface.break(item) || call_item_handler(GAME_MENU, item)

        if @dealer.cards_num == MAX_CARDS && @gamer.cards_num == MAX_CARDS
          show_and_finish_game
          return
        end
      rescue RuntimeError => e
        puts e
      end
    end
  end

  def skip_the_game
    if @dealer.cards_sum >= DEALER_CARDS_SUM
      @interface.dealer_miss_turn
    else
      @dealer.add_cards(@game_deck.get_cards(1))
      @interface.dealer_add_card
      @interface.show_cards(@gamer)
      @interface.show_cards(@dealer, true)
    end
  end

  def add_cards
    raise @interface.err_three_cards if @gamer.cards_num >= 3

    @gamer.add_cards(@game_deck.get_cards(1))
    @interface.show_cards(@gamer)
    @interface.show_cards(@dealer, true)
  end

  def show_and_finish_game
    @interface.show_cards(@gamer)
    @interface.show_cards(@dealer)
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
    elsif (gamer_sum > dealer_sum || dealer_sum > BJ_SUM) && gamer_sum <= BJ_SUM
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
end
