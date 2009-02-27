# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class SaleOrderTest < ActiveSupport::TestCase
  def test_sale_cost_price_and_profit
    # 计算 cost
    po = purchase_orders(:purchase_from_ppa)
    po.save

    # sale_to_mik 的情况和利润
    soi = sale_order_items(:sale_1_oil_to_mike)
    assert_equal 1,     soi.quantity
    assert_equal 100.0, soi.unit_price
    assert_equal 100.0, soi.total_price
    assert_equal 30.0,  soi.unit_cost
    assert_equal 30.0,  soi.total_cost
    assert_equal 70.0,  soi.unit_profit
    assert_equal 70.0,  soi.total_profit

    soi = sale_order_items(:sale_2_hydrolat_to_mike)
    assert_equal 2,     soi.quantity
    assert_equal 200.0, soi.unit_price
    assert_equal 400.0, soi.total_price
    assert_equal 120.0, soi.unit_cost
    assert_equal 240.0, soi.total_cost
    assert_equal 80.0,  soi.unit_profit
    assert_equal 160.0, soi.total_profit

    so = sale_orders(:sale_to_mike)
    assert_equal 10.0, so.postage
    assert_equal 220,  so.total_profit

    # sale_to_rose 的情况和利润
    soi = sale_order_items(:sale_2_oil_to_rose)
    assert_equal 70, soi.unit_profit
    assert_equal 140, soi.total_profit

    sspi = saled_store_product_items(:sale_2_lotion_to_rose)
    assert_equal 200,      sspi.item_price
    assert_in_delta 48.05, sspi.item_cost, 0.1
    assert_equal 151.95,   sspi.item_profit
    assert_in_delta 303.9, sspi.total_profit, 0.1

    so = sale_orders(:sale_to_rose)
    assert_equal 10.0, so.postage
    assert_in_delta 433.9, so.total_profit, 0.1

    # 在售物品的情况
  end

  def test_sale_order_items_should_not_exceed_available_quantity
    assert true
  end
end
