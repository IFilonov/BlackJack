require_relative 'pack'

class Gamer
  attr_accessor :name
  attr_accessor :pack

  def initialize(name = '')
    @pack = Pack.new
    @name = name.capitalize
  end

  def cards_name
    @pack.cards_name
  end

  def cards_sum
    @pack.sum
  end

  def cards_num
    @pack.cards.size
  end

  def add_cards(cards)
    @pack.add_cards(cards)
  end
end
