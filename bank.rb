class Bank
  START_SUM_MONEY = 100
  GAME_SUM_MONEY = 10

  attr_reader :accounts

  def initialize
    @accounts = {
      gamer: START_SUM_MONEY,
      dealer: START_SUM_MONEY,
      game: 0
    }
    @last_sum = 0
  end

  def charge_game(money = GAME_SUM_MONEY)
    if @accounts[:gamer] >= money && @accounts[:dealer] >= money
      @accounts[:gamer] -= money
      @accounts[:dealer] -= money
      @accounts[:game] += 2 * money
    end
    @last_sum += -money
  end

  def enough_money_for_game?
    if @accounts[:gamer] >= GAME_SUM_MONEY && @accounts[:dealer] >= GAME_SUM_MONEY
      return true
    end

    false
  end

  def rollback
    charge_game(@last_sum)
    @last_sum = 0
  end

  def game_money
    @accounts[:game]
  end

  def gamer_money
    @accounts[:gamer]
  end

  def dealer_money
    @accounts[:dealer]
  end

  def dealer_win
    @accounts[:dealer] += @accounts[:game]
    @accounts[:game] = 0
    @last_sum = 0
  end

  def gamer_win
    @accounts[:gamer] += @accounts[:game]
    @accounts[:game] = 0
    @last_sum = 0
  end
end
