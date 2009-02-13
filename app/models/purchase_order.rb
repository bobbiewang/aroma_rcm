# -*- coding: utf-8 -*-
class PurchaseOrder < ActiveRecord::Base
  validate :purchase_order_items_must_be_valid

  belongs_to :vendor
  has_many :purchase_order_items

  after_update :save_purchase_order_items
  after_create :calculate_purchase_order_item_costs
  after_update :calculate_purchase_order_item_costs

  def total_weight
    purchase_order_items.inject(0.0) { |sum, item| sum += item.total_weight }
  end

  def total_price
    items = purchase_order_items.select { |item| item.unit_price }

    if items.empty?
      # 如果所有 purchase_order_items 的 price 都没有，返回 0.0
      return 0.0
    else
      # 只要 purchase_order_items 中有 price，就求和
      # 一个特殊情况是所有 price 为 0，从而和为 0
      items.inject(0.0) { |sum, item| sum + item.total_price }
    end
  end

  def total_price_with_postage
    total_price + postage
  end

  def new_purchase_order_item_attributes=(purchase_order_item_attributes)
    purchase_order_item_attributes.each do |attributes|
      # 如果不指定 :purchase_order_id，通不过 validation。这里设置一个
      # 虚假的数字，在保存 PurchaseOrder 的时候会使用正确的值
      attributes[:purchase_order_id] = 0
      purchase_order_items.build(attributes)
    end
  end

  def existing_purchase_order_item_attributes=(purchase_order_item_attributes)
    purchase_order_items.reject(&:new_record?).each do |purchase_order_item|
      attributes = purchase_order_item_attributes[purchase_order_item.id.to_s]
      if attributes
        purchase_order_item.attributes = attributes
      else
        purchase_order_items.delete(purchase_order_item)
      end
    end
  end

  protected

  def purchase_order_items_must_be_valid
    purchase_order_items.each do |item|
      errors.add(:purchase_order_items, item.errors.full_messages) unless item.valid?
    end
  end

  def save_purchase_order_items
    purchase_order_items.each { |item| item.save(false) }
  end

  def calculate_purchase_order_item_costs
    return if total_cost.nil? or purchase_order_items.size == 0 or total_price.nil?

    purchase_order_items.each do |item|
      # 由于虚拟 weight 的存在，即使一个 item 没有 price，也会有 cost
      unit_price = item.unit_price.nil? ? 0.0 : item.unit_price

      item.unit_cost = (unit_price + postage *  item.unit_weight / total_weight) *
                       total_cost / total_price_with_postage

      # 根据 unit_cost 计算 ml_cost 和 drop_cost
      unless item.vendor_product.capacity.nil?
        item.ml_cost = item.unit_cost / item.vendor_product.capacity
        item.drop_cost = item.ml_cost / 20.0
      end
      item.save
    end
  end
end
