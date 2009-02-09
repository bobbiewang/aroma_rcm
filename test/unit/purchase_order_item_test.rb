require 'test_helper'

class PurchaseOrderItemTest < ActiveSupport::TestCase
  def test_valid_purchase_order_items
    purchase_order_item = PurchaseOrderItem.new(:purchase_order_id => 1,
                                                :vendor_product_id => 1,
                                                :unit_price => 1.1,
                                                :quantity => 1)
    assert_valid(purchase_order_item)
  end
end
