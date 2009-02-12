# -*- coding: utf-8 -*-
class PurchaseOrderItem < ActiveRecord::Base
  validates_presence_of :purchase_order_id, :vendor_product_id, :quantity
  validates_numericality_of :purchase_order_id, :vendor_product_id
  validates_numericality_of :unit_price, :allow_nil => true

  validate :quantity_should_be_positive_or_minus_one

  belongs_to :purchase_order
  belongs_to :vendor_product
  has_many :sale_order_items

  after_update :update_sale_order_item_costs

  def total_price
    # 如果 unit_price 是 nil，返回 nil；否则正常计算
    return nil unless unit_price
    unit_price * quantity
  end

  def avail_quantity
    quantity - saled_quantity
  end

  def saled_quantity
    sale_order_items.inject(0) { |sum, item| sum += item.quantity }
  end

  protected
  def quantity_should_be_positive_or_minus_one
    unless quantity > 0 or quantity == -1
      errors.add(:quantity, "should be positive number or -1.")
    end
  end

  def update_sale_order_item_costs
    return unless unit_cost

    sale_order_items.each do |item|
      item.unit_cost = self.unit_cost
      item.save
    end
  end
end
