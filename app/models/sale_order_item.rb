# -*- coding: utf-8 -*-
class SaleOrderItem < ActiveRecord::Base
  belongs_to :sale_order
  belongs_to :purchase_order_item

  validate_on_create :should_not_exceed_available_quantity_on_create

  def self.total_saled_price
    SaleOrderItem.find(:all).inject(0) { |sum,i| sum += i.total_price }
  end

  def should_not_exceed_available_quantity_on_create
    return if purchase_order_item.avail_quantity == -1

    if quantity > purchase_order_item.avail_quantity
      errors.add(:quantity, "exceeds available amount.")
    end
  end

  def unit_cost
    # 1.x 版本中，把自制产品也作为 vendor product，所以进货的成本可能为空（未定）
    purchase_order_item.unit_cost || 0.0
  end

  def total_cost
    quantity * unit_cost
  end

  def total_price
    quantity * unit_price
  end

  def unit_profit
    unit_price - unit_cost
  end

  def total_profit
    quantity * (unit_price - unit_cost)
  end
end
