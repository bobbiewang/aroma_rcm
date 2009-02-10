class PurchaseOrderItem < ActiveRecord::Base
  validates_presence_of :purchase_order_id, :vendor_product_id, :quantity
  validates_numericality_of :purchase_order_id, :vendor_product_id
  validates_numericality_of :unit_price, :allow_nil => true

  belongs_to :purchase_order
  belongs_to :vendor_product

  def total_price
    unit_price * quantity
  end

  def avail_quantity
    quantity
  end
end
