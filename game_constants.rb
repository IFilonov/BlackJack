module GameConstants
  START_MENU = [
    { label: 'Continue game', handler: :process_game, exit_loop: false }
  ].freeze

  GAME_MENU = [
    { label: 'Skip the game', handler: :skip_the_game, exit_loop: false },
    { label: 'Add card', handler: :add_cards, exit_loop: false },
    { label: 'Show cards', handler: :show_and_finish_game, exit_loop: true }
  ].freeze

  ONE_GAME_MONEY = 10

  MAX_CARDS = 3

  DEALER_CARDS_SUM = 17

  BJ_SUM = 21
end
