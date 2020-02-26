class Market

  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.find do | items |
        items.first == item
      end
    end
  end

  def total_inventory
    @vendors.reduce({}) do |inventory, vendor|
      vendor.inventory.each do |items|
        if inventory.key? items.first
          inventory[items.first][:quantity] += items.last
          inventory[items.first][:vendors] << vendor
        else
          inventory[items.first] = {
            quantity: items.last,
            vendors: [vendor]
          }
        end
      end
      inventory
    end
  end

  def overstocked_items
    overstocked_items = total_inventory.find_all do |items|
      items.last[:quantity] > 50
    end
    overstocked_items.map { | items | items.first }
  end

  def sorted_item_list
    total_inventory.map do | items |
      items.first.name
    end.sort
  end

end
