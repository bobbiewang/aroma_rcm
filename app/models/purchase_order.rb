# -*- coding: utf-8 -*-
class PurchaseOrder < ActiveRecord::Base
  validate :purchase_order_items_must_be_valid

  belongs_to :vendor
  has_many :purchase_order_items

  after_create :calculate_purchase_order_item_costs
  after_update :calculate_purchase_order_item_costs

  def new_purchase_order_item_attributes=(purchase_order_item_attributes)
    purchase_order_item_attributes.each do |attributes|
      # 如果不指定 :purchase_order_id，通不过 validation。这里设置一个
      # 虚假的数字，在保存 PurchaseOrder 的时候会使用正确的值
      attributes[:purchase_order_id] = 0
      purchase_order_items.build(attributes)
    end
  end

  protected
  def purchase_order_items_must_be_valid
    purchase_order_items.each do |item|
      errors.add(:purchase_order_items, item.errors.full_messages) unless item.valid?
    end
  end

  def calculate_purchase_order_item_costs
    return if total_cost.nil? or purchase_order_items.size == 0

    purchase_order_items.each do |item|
      item.unit_cost = total_cost / items_total_price * item.unit_price
      unless item.vendor_product.capacity.nil?
        item.ml_cost = item.unit_cost / item.vendor_product.capacity
        item.drop_cost = item.ml_cost / 20.0
      end
      item.save
    end
  end

  def items_total_price
    purchase_order_items.inject(0.0) { |sum, item| sum + item.total_price }
  end
end
