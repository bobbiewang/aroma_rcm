require File.dirname(__FILE__) + '/../test_helper'

class StoreProductItemTest < ActiveSupport::TestCase
  def test_cost
    purchase_orders(:purchase_from_ppa).save

    spi = store_product_items(:one_cream)
    assert_equal 72.3, spi.item_cost
    assert_equal 72.3, spi.total_cost

    spi = store_product_items(:three_lotion)
    assert_in_delta 48.05,  spi.item_cost, 0.1
    assert_equal 3,         spi.quantity
    assert_in_delta 144.15, spi.total_cost, 0.1
  end
end
