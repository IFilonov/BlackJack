require_relative 'game_constants'

module GameProcess
  include GameConstants

  private

  def prepare_new_game
    @gamer.add_cards(@game_pack.get_cards(2))
    @dealer.add_cards(@game_pack.get_cards(2))
    show_cards(@gamer)
    show_cards(@dealer, true)
    @bank.charge_game(ONE_GAME_MONEY)
  end

  def process_game
    prepare_new_game
    loop do
      begin
        show_menu(GAME_MENU)
        item = gets.chomp.to_s
        break if item == QUIT_MENU || call_item_handler(GAME_MENU, item)

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
      puts 'Dealer miss a turn'
    else
      @dealer.add_cards(@game_pack.get_cards(1))
      puts 'Dealer add a card'
      show_cards(@gamer)
      show_cards(@dealer, true)
    end
  end

  def add_cards
    raise 'You cannot add more than 3 cards!' if @gamer.cards_num >= 3

    @gamer.add_cards(@game_pack.get_cards(1))
    show_cards(@gamer)
    show_cards(@dealer, true)
  end

  def show_and_finish_game
    show_cards(@gamer)
    show_cards(@dealer)
    finish_game
  end

  def show_cards(gamer, hide = false)
    print "#{gamer.name}! "
    puts "Sum cards: #{hide ? '***' : gamer.pack.sum}, cards:"
    gamer.cards_name.each { |name| puts hide ? '***' : name }
  end

  def finish_game
    gamer_sum = @gamer.cards_sum
    dealer_sum = @dealer.cards_sum
    if gamer_sum == dealer_sum
      show_finish_bank('DRAW!')
      @bank.roolback
    elsif gamer_sum > BJ_SUM && dealer_sum > BJ_SUM
      puts 'NO WINS!'
    elsif (gamer_sum > BJ_SUM || gamer_sum < dealer_sum) && dealer_sum <= BJ_SUM
      @bank.dealer_win
      show_finish_bank('Dealer WIN!')
    elsif (gamer_sum > dealer_sum || dealer_sum > BJ_SUM) && gamer_sum <= BJ_SUM
      @bank.gamer_win
      show_finish_bank('Gamer WIN!')
    end
    flush_gamers_cards
  end

  def show_finish_bank(claim)
    print claim
    print " Gamer #{@gamer.name} "
    puts "bank: #{@bank.gamer_money}, dealer bank: #{@bank.dealer_money}"
  end

  def flush_gamers_cards
    @dealer.pack.flush
    @gamer.pack.flush
  end
end
