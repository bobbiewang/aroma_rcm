# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class SaleOrderItemTest < ActiveSupport::TestCase
  def test_sale_order_items_should_not_exceed_available_quantity_on_create
    assert_equal 3, purchase_order_items(:purchase_4_ppa_oil).avail_quantity

    # 购买 4 个，销售 1 + 999 个，失败
    soi = SaleOrderItem.new(:sale_order_id => sale_orders(:sale_to_mike).id,
                            :purchase_order_item_id => purchase_order_items(:purchase_4_ppa_oil).id,
                            :unit_cost => 9.9,
                            :unit_price => 9.9,
                            :quantity => 999)
    assert !soi.valid?, "not enough availible items."
    assert soi.errors.invalid?(:quantity)
    assert_equal "exceeds available amount.", soi.errors.on(:quantity)
  end

  def test_sale_order_items_will_not_execeed_minus_one_quantity
    # 购买 -1（无穷）个，销售 1+999 个，成功
    assert_equal -1, purchase_order_items(:purchase_cream).avail_quantity
    soi = SaleOrderItem.new(:sale_order_id => sale_orders(:sale_to_tom).id,
                            :purchase_order_item_id => purchase_order_items(:purchase_cream).id,
                            :unit_cost => 9.9,
                            :unit_price => 9.9,
                            :quantity => 999)
    assert soi.valid?, soi.errors.full_messages
  end
end
