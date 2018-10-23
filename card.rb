class Card
  attr_reader :value, :name

  TYPES = ['+', '<3', '<>', '^'].freeze
  NUMBERS = %w[2 3 4 5 6 7 8 9 10 V D K T].freeze

  ACE_VALUE = 11
  PICT_VALUE = 10
  ERR_N = 'Error! Not correct number!'.freeze
  ERR_T = 'Error! Not correct type!'.freeze

  def initialize(number, type)
    @number = number
    @type = type
    @name = number + type
    @value = calc_value(number)
    validate!
  end

  private

  def calc_value(number)
    if number.to_i.to_s == number
      number.to_i
    else ace? ? ACE_VALUE : PICT_VALUE
    end
  end

  def ace?
    @name.include?(NUMBERS.last)
  end

  def validate!
    raise ERR_N unless NUMBERS.include?(@number)
    raise ERR_T unless TYPES.include?(@type)
  end
end
