# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class PurchaseOrderTest < ActiveSupport::TestCase

  def test_calculate_cost_of_items
    po = purchase_orders(:from_ppa)
    po.save
    items = po.purchase_order_items

    # 查看 Order 信息
    assert_equal 3,    items.size
    # oil, 10ml
    assert_equal 5.0,  items[0].unit_price
    assert_equal 4,    items[0].quantity
    assert_equal 10,   items[0].vendor_product.capacity
    # hydrolat, 500ml
    assert_equal 10.0, items[1].unit_price
    assert_equal 3,    items[1].quantity
    assert_equal 500,  items[1].vendor_product.capacity
    # box
    assert_equal 50.0, items[2].unit_price
    assert_equal 2,    items[2].quantity
    assert_nil         items[2].vendor_product.capacity

    # 确认现在的 item 还没有 cost
    assert_nil items[0].unit_cost
    assert_nil items[0].ml_cost
    assert_nil items[0].drop_cost
    assert_nil items[1].unit_cost
    assert_nil items[1].ml_cost
    assert_nil items[1].drop_cost
    assert_nil items[2].unit_cost
    assert_nil items[2].ml_cost
    assert_nil items[2].drop_cost

    # 设置 total_cost，会自动计算 items 的 cost
    po.postage = 20
    po.total_cost = 600
    po.save

    # 确认 item 的 cost 已经计算出
    assert_equal 20.0,  items[0].unit_cost
    assert_equal 2.0,   items[0].ml_cost
    assert_equal 0.1,   items[0].drop_cost
    assert_equal 40.0,  items[1].unit_cost
    assert_equal 0.08,  items[1].ml_cost
    assert_equal 0.004, items[1].drop_cost
    assert_equal 200.0, items[2].unit_cost
    assert_nil          items[2].ml_cost
    assert_nil          items[2].drop_cost
  end

  def test_order_with_no_price_items
    po = purchase_orders(:from_qing)
    po.save
    items = po.purchase_order_items

    # 查看 Order 信息
    assert_equal 1,  items.size
    # cream
    assert_nil       items[0].unit_price
    assert_equal 1,  items[0].quantity
    assert_equal 30, items[0].vendor_product.capacity

    # 确认现在的 item 还没有 cost
    assert_nil items[0].unit_cost
    assert_nil items[0].ml_cost
    assert_nil items[0].drop_cost

    # 设置 total_cost，对于没有 price 的 item，不计算 cost
    po.postage = 20
    po.total_cost = 300
    po.save

    # 确认 item 还是没有 cost
    assert_nil items[0].unit_cost
    assert_nil items[0].ml_cost
    assert_nil items[0].drop_cost
  end
end
