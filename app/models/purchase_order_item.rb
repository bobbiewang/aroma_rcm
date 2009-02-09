class PurchaseOrderItem < ActiveRecord::Base
  validates_presence_of :purchase_order_id, :vendor_product_id, :unit_price, :quantity
  validates_numericality_of :purchase_order_id, :vendor_product_id, :unit_price

  belongs_to :purchase_order
  belongs_to :vendor_product

  def total_price
    unit_price * quantity
  end
end
