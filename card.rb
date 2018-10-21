class Card
  attr_reader :value, :name

  ACE_VALUE = 11

  def initialize(number, type)
    @name = number + type
    @value = calc_value(number)
  end

  def calc_value(number)
    if number.to_i.to_s == number
      number.to_i
    elsif ace?
      ACE_VALUE
    else
      10
    end
  end

  private

  def ace?
    @name.include?('T')
  end
end
