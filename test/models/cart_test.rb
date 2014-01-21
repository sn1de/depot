require 'test_helper'

class CartTest < ActiveSupport::TestCase

  test "one product only, please" do
    c = Cart.new
    c.add_product(products(:ruby))

    assert_equal(c.total_price, products(:ruby).price, 'cart total for one item should equal the price of that item')

  end

  test "two products cart total" do
    c = Cart.new
    c.add_product(products(:ruby))
    c.add_product(products(:two))

    assert_equal(c.total_price, products(:ruby).price + products(:two).price, 'cart total for two products should equal the sum of each products price')
  end

  test "multiple product quantities in cart" do
    c = Cart.new
    p = products(:ruby)
    c.add_product(p.id).save!
    c.add_product(p.id).save!
    c.add_product(p.id).save!

    assert_equal(products(:ruby).price * 3, c.total_price, '3 products, 3 times the price')
    assert_equal(1, c.line_items.size, 'add same product more than once results in one line item')
  end

end
