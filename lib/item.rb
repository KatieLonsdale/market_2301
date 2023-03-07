class Item
  attr_reader :name, :price

  def initialize(attributes)
    @name = attributes[:name]
    @price = format_price(attributes[:price])
  end

  def format_price(string_price)
    string_price.delete('$').to_f
  end
end
