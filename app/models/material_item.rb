class MaterialItem < ActiveRecord::Base
  validates_presence_of :purchase_order_id, :vendor_product_id, :quantity
  validates_numericality_of :purchase_order_id, :vendor_product_id, :quantity
  validates_numericality_of :item_price, :allow_nil => true
  validates_numericality_of :item_cost, :allow_nil => true

  belongs_to :purchase_order
  belongs_to :vendor_product

  def title
    vendor_product.title
  end

  def total_price
    item_price * quantity
  end

  def total_cost
    item_cost * quantity
  end

  def unit_cost
    item_cost / vendor_product.material_amount
  end

  def total_material_amount
    quantity * vendor_product.material_amount
  end

  def item_weight
    vendor_product.postage_weight
  end

  def total_weight
    quantity * item_weight
  end
end
