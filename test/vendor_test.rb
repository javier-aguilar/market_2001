require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'

class VendorTest < Minitest::Test

  def setup
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_attributes
    expected = {}
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal expected, @vendor.inventory
  end

  def test_it_can_stock
    assert_equal 0, @vendor.check_stock(@item1)
    @vendor.stock(@item1, 30)
    expected = { @item1 => 30 }
    assert_equal expected, @vendor.inventory
    assert_equal 30, @vendor.check_stock(@item1)

    @vendor.stock(@item1, 25)
    expected = { @item1 => 55 }
    assert_equal expected, @vendor.inventory
    assert_equal 55, @vendor.check_stock(@item1)

    @vendor.stock(@item2, 12)
    expected = { @item1 => 55, @item2 => 12 }
    assert_equal expected, @vendor.inventory
  end

end
