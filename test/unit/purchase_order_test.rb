require File.dirname(__FILE__) + '/../test_helper'

class PurchaseOrderTest < ActiveSupport::TestCase

  def test_calculate_cost_of_items
    po = purchase_orders(:from_ppa)
    items = po.purchase_order_items

    assert_equal 2,    items.size
    assert_equal 5.0,  items[0].unit_price
    assert_equal 2,    items[0].quantity
    assert_equal 10.0, items[1].unit_price
    assert_equal 1,    items[1].quantity

    po.postage = 20
    po.total_cost = 200
    po.save

    assert_equal 50.0,  items[0].unit_cost
    assert_equal 100.0, items[1].unit_cost
  end
end
