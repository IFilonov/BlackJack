class GamePack < Pack
  TYPES = ['+', '<3', '<>', '^'].freeze
  NUMBERS = %w[2 3 4 5 6 7 8 9 10 V D K T].freeze

  def initialize
    super
    fill_cards
    @cards.shuffle!
  end

  def fill_cards
    TYPES.each do |type|
      NUMBERS.each { |number| @cards.push(Card.new(number, type)) }
    end
  end

  def flush
    super
    fill_cards
  end
end
