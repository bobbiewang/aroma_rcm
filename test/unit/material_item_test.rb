require File.dirname(__FILE__) + '/../test_helper'

class MaterialItemsTest < ActiveSupport::TestCase
  def test_cost
    purchase_orders(:purchase_from_ppa).save

    mi = material_items(:purchase_2_ppa_oil)
    assert_equal 2,    mi.quantity
    assert_equal 30,   mi.item_cost
    assert_equal 60,   mi.total_cost
    assert_equal 400,  mi.total_material_amount
    assert_equal 0.15, mi.unit_cost
  end
end
