# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class PurchaseOrderItemTest < ActiveSupport::TestCase
  def test_valid_purchase_order_items
    purchase_order_item = PurchaseOrderItem.new(:purchase_order_id => 1,
                                                :vendor_product_id => 1,
                                                :unit_price => 1.1,
                                                :quantity => 1)
    assert_valid(purchase_order_item)
  end

  def test_should_update_sale_order_items
    poi = purchase_order_items(:purchase_4_ppa_oil)
    sois = poi.sale_order_items

    poi.unit_cost = 10.0
    poi.save
    assert_equal poi.unit_cost, sois[0].unit_cost

    poi.unit_cost = 20.0
    poi.save
    assert_equal poi.unit_cost, sois[0].unit_cost
  end

  def test_should_not_update_sale_order_items
    # 如果 PurchaseOrderItem.unit_cost 为空，不更新其 SaleOrderItem.uni_cost
    poi = purchase_order_items(:purchase_1_cream)
    sois = poi.sale_order_items

    sois[0].unit_cost = 199.9
    sois[0].save
    poi.unit_cost = nil
    poi.save
    assert_equal 199.9, sois[0].unit_cost
  end
end
