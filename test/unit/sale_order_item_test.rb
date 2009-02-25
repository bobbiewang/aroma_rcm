# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class SaleOrderItemTest < ActiveSupport::TestCase
  def test_sale_order_items_should_not_exceed_available_quantity_on_create
    assert_equal 3, purchase_order_items(:purchase_4_ppa_oil).avail_quantity

    # 购买 4 个，销售 1 + 999 个，失败
    soi = SaleOrderItem.new(:sale_order_id => sale_orders(:sale_to_mike).id,
                            :purchase_order_item_id => purchase_order_items(:purchase_4_ppa_oil).id,
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
                            :unit_price => 9.9,
                            :quantity => 999)
    assert soi.valid?, soi.errors.full_messages
  end

  def test_profit
    # 更新 cost
    po = purchase_orders(:purchase_from_ppa)
    po.save

    # 验证不同情况下的 profit
    soi = sale_order_items(:sale_1_oil_to_mike)
    assert_equal 70, soi.total_profit

    soi.quantity = 2
    assert_equal 140, soi.total_profit

    soi.unit_price = 1
    assert_equal -58, soi.total_profit
  end
end
