class Item

  attr_reader :name, :price

  def initialize(item_info)
    @name = item_info[:name]
    @price = parse_price(item_info[:price])
  end

  def parse_price(price)
    price.to_s.tr('$', '').to_f
  end

end
