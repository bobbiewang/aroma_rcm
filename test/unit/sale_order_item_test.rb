require File.dirname(__FILE__) + '/../test_helper'

class SaleOrderItemTest < ActiveSupport::TestCase
  def test_sale_order_items_should_not_exceed_available_quantity_on_create
    assert_equal 3, purchase_order_items(:purchase_4_ppa_oil).avail_quantity

    soi = SaleOrderItem.new(:sale_order_id => sale_orders(:sale_to_mike).id,
                            :purchase_order_item_id => 4,
                            :unit_cost => 9.9,
                            :unit_price => 9.9,
                            :quantity => 4)
    assert !soi.valid?, "not enough availible items."
    assert soi.errors.invalid?(:quantity)
    assert_equal "exceeds available amount.", soi.errors.on(:quantity)
  end
end
