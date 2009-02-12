# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class PurchaseOrderItemTest < ActiveSupport::TestCase
  def test_valid_purchase_order_items
    poi = PurchaseOrderItem.new(:purchase_order_id => 1,
                                :vendor_product_id => 1,
                                :unit_price => 1.1,
                                :quantity => 1)
    assert_valid(poi)
  end

  def test_purchase_quantity_should_be_positive_or_minus_one
    poi = PurchaseOrderItem.new(:purchase_order_id => 1,
                                :vendor_product_id => 1,
                                :unit_price => 1.1,
                                :quantity => 1)
    assert poi.valid?

    poi.quantity = 0
    assert !poi.valid?, "Invalid quantity: 0."
    assert_equal "should be positive number or -1.", poi.errors.on(:quantity)

    poi.quantity = -1
    assert poi.valid?, poi.errors.full_messages

    poi.quantity = -2
    assert !poi.valid?, "Invalid quantity: 0."
    assert_equal "should be positive number or -1.", poi.errors.on(:quantity)
  end

  def test_saled_quantity
    poi = purchase_order_items(:purchase_4_ppa_oil)
    assert_equal 1, poi.sale_order_items.size
    assert_equal 1, poi.sale_order_items[0].quantity

    assert_equal 1, poi.saled_quantity
  end

  def test_used_quantity
    # TODO
  end

  def test_archived_quantity
    # TODO
  end

  def test_avail_quantity
    # 购买 4 个，销售 1 个，剩余 3 个
    poi = purchase_order_items(:purchase_4_ppa_oil)
    assert_equal 4, poi.quantity
    assert_equal 1, poi.saled_quantity
    assert_equal 3, poi.avail_quantity

    # 购买 -1（无穷）个，销售 1 个，剩余 -1（无穷）个
    poi = purchase_order_items(:purchase_cream)
    assert_equal -1, poi.quantity
    assert_equal 1,  poi.saled_quantity
    assert_equal -1, poi.avail_quantity
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
    poi = purchase_order_items(:purchase_cream)
    sois = poi.sale_order_items

    sois[0].unit_cost = 199.9
    sois[0].save
    poi.unit_cost = nil
    poi.save
    assert_equal 199.9, sois[0].unit_cost
  end
end
