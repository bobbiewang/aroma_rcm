# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class PurchaseOrderTest < ActiveSupport::TestCase
  def test_total_price
    po = purchase_orders(:purchase_from_ppa)
    assert_equal 150.0, po.total_price
  end

  def test_postage_percentage
    po = purchase_orders(:purchase_from_ppa)

    po.postage = 75.0
    assert_equal 0.5, po.postage_percentage
  end

  def test_cost_price_rate
    po = purchase_orders(:purchase_from_ppa)

    assert_equal 2, po.cost_price_rate

    po.total_cost = 2280
    assert_equal 4, po.cost_price_rate

    po.total_cost = nil
    assert_equal 0.0, po.cost_price_rate
  end

  def test_item_total_weight
    po = purchase_orders(:purchase_from_ppa)

    assert_equal 200,  po.total_product_weight
    assert_equal 10,   po.material_items[0].item_weight
    assert_equal 2,    po.material_items[0].quantity
    assert_equal 50,   po.material_items[1].item_weight
    assert_equal 4,    po.material_items[1].quantity
    assert_equal 220,  po.total_material_weight
    assert_equal 420,  po.total_weight
  end

  def test_calculate_cost_of_items
    # 计算 cost
    po = purchase_orders(:purchase_from_ppa)
    po.save

    # 该 purchase order 的一些信息
    assert_equal 1140, po.total_cost
    assert_equal 420,  po.postage
    assert_equal 150,  po.total_price
    assert_equal 570,  po.total_price_with_postage
    assert_equal 420,  po.total_weight

    # 成品的成本
    assert_equal 30.0, purchase_order_items(:purchase_4_ppa_oil).unit_cost
    assert_equal 120,  purchase_order_items(:purchase_3_ppa_hydrolat).unit_cost
    assert_equal 12,   purchase_order_items(:purchase_10_ppa_box).unit_cost

    # 原料的成本
    assert_equal 30.0,  material_items(:purchase_2_ppa_oil).item_cost
    assert_equal 0.15,  material_items(:purchase_2_ppa_oil).unit_cost
    assert_equal 120.0, material_items(:purchase_4_ppa_hydrolat).item_cost
    assert_equal 2.4,   material_items(:purchase_4_ppa_hydrolat).unit_cost
  end

  def test_should_set_item_cost_to_0_whose_price_is_0
    # 如果所有 item 的 unit_price 为 0，同时 postage 也为 0，计算
    # unit_cost 的时候，会造成除法错误，要特殊处理

    po = purchase_orders(:purchase_from_ppa)
    items = po.purchase_order_items
    items.each do |item|
      item.unit_price = 0.0
    end

    po.postage = 0
    po.total_cost = 0.0
    po.save

    assert_equal 0.0, items[0].unit_cost
    assert_equal 0.0, items[1].unit_cost
    assert_equal 0.0, items[2].unit_cost
  end
end
