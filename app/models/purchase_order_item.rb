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

  def self.total_on_sale_cost
    PurchaseOrderItem.find(:all).inject(0.0) { |sum, item| sum += item.on_sale_cost }
  end

  def self.total_profit
    PurchaseOrderItem.find(:all).inject(0.0) { |sum, item| sum += item.profit }
  end

  def self.avail_items
    PurchaseOrderItem.find(:all).select { |item| item.avail? }
  end

  def unit_weight
    # 目前产品没有重量的概念，用容量模拟重量。没有容量的产品算 1ml。
    # 因为 weight 是用于分担运费计算 cost，所以如果某个产品没有
    # unit_price，那么 weight 也算 0，从而不分担运费
    return 0 if unit_price.nil?

    capacity = vendor_product.capacity
    capacity.nil? ? 1 : capacity
  end

  def total_weight
    unit_weight * quantity
  end

  def total_price
    # 如果 unit_price 无效或者 quantity 为无穷，返回 0.0；否则正常计算
    return 0.0 if unit_price.nil? or quantity == -1

    unit_price * quantity
  end

  def total_cost
    # 如果 unit_cost 无效或者 quantity 为无穷，返回 0.0；否则正常计算
    return 0.0 if unit_cost.nil? or quantity == -1

    unit_cost * quantity
  end

  def on_sale_cost
    return 0.0 if avail_quantity == -1 or unit_cost.nil?

    unit_cost * avail_quantity
  end

  def profit
    sale_order_items.inject(0.0) { |sum, item| sum += item.total_profit }
  end

  def saled_quantity
    sale_order_items.inject(0) { |sum, item| sum += item.quantity }
  end

  def avail_quantity
    return -1 if quantity == -1

    left = quantity - saled_quantity
    left = -2 if left == -1
    left
  end

  def avail?
    avail_quantity > 0 or avail_quantity == -1
  end

  protected
  def quantity_should_be_positive_or_minus_one
    unless quantity > 0 or quantity == -1
      errors.add(:quantity, "should be positive number or -1.")
    end
  end

  def avail_quantity_should_be_positive_or_minus_one
    unless avail_quantity > 0 or avail_quantity == -1
      errors.add_to_base("No enough available items..")
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
