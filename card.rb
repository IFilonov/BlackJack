class Card
  attr_reader :value, :name

  TYPES = ['+', '<3', '<>', '^'].freeze
  NUMBERS = %w[2 3 4 5 6 7 8 9 10 V D K T].freeze

  ACE_VALUE = 11
  PICT_VALUE = 10
  ERR_N = 'Error! Not correct number!'.freeze
  ERR_T = 'Error! Not correct number!'.freeze

  def initialize(number, type)
    raise ERR_M unless NUMBERS.include?(number)
    raise ERR_T unless TYPES.include?(type)

    @name = number + type
    @value = calc_value(number)
  end

  def calc_value(number)
    value = number.to_i
    value = PICT_VALUE if value.zero?
    value = ACE_VALUE if ace?
    value
  end

  private

  def ace?
    @name.include?('T')
  end
end
