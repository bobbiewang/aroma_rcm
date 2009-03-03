# -*- coding: utf-8 -*-

require 'iconv'

class PurchaseOrderItem < ActiveRecord::Base
  validates_presence_of :purchase_order_id, :vendor_product_id, :quantity
  validates_numericality_of :purchase_order_id, :vendor_product_id
  validates_numericality_of :unit_price, :allow_nil => true

  before_destroy :validates_no_dependents

  validate :quantity_should_be_positive_or_minus_one

  belongs_to :purchase_order
  belongs_to :vendor_product
  has_many :sale_order_items

  def validates_no_dependents
    unless sale_order_items.count == 0
      errors.add_to_base "Cannot delete this purchase order, as part of it were saled."
      false
    end
  end

  def self.total_on_sale_cost
    PurchaseOrderItem.find(:all).inject(0.0) { |sum, item| sum += item.on_sale_cost }
  end

  def self.total_profit
    PurchaseOrderItem.find(:all).inject(0.0) { |sum, item| sum += item.profit }
  end

  def self.avail_items
    conv = Iconv.new("GBK", "utf-8")

    items = PurchaseOrderItem.find(:all).select { |item| item.avail? }
    items.sort do |x, y|
      if x.purchase_order.vendor.id != y.purchase_order.vendor.id
        x.purchase_order.vendor.id <=> y.purchase_order.vendor.id
      elsif x.vendor_product.title != y.vendor_product.title
        conv.iconv(x.vendor_product.title) <=> conv.iconv(y.vendor_product.title)
      else
        x.purchase_order.purchased_at <=> y.purchase_order.purchased_at
      end
    end
  end

  def vendor_and_title
    "#{vendor_product.vendor.abbr_name} - #{vendor_product.title}"
  end

  def unit_weight
    vendor_product.postage_weight
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

  def total_profit
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
    unless quantity.nil? or quantity > 0 or quantity == -1
      errors.add(:quantity, "should be positive number or -1.")
    end
  end

  def avail_quantity_should_be_positive_or_minus_one
    unless avail_quantity > 0 or avail_quantity == -1
      errors.add_to_base("No enough available items..")
    end
  end
end
