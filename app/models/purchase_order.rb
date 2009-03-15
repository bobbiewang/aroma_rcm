# -*- coding: utf-8 -*-
class PurchaseOrder < ActiveRecord::Base
  validates_associated :purchase_order_items
  validates_associated :material_items

  before_destroy :validates_no_dependents

  belongs_to :vendor
  has_many :purchase_order_items, :dependent => :destroy
  has_many :material_items, :dependent => :destroy

  after_update :save_purchase_order_items_and_material_items
  after_create :calculate_purchase_order_item_costs
  after_update :calculate_purchase_order_item_costs

  def self.total_cost
    PurchaseOrder.find(:all).inject(0) { |sum, i| sum += i.total_cost }
  end

  def validates_no_dependents
    saled_count = purchase_order_items.inject(0) { |sum, i| sum += i.sale_order_items.size }
    used_count =  material_items.inject(0) { |sum, i| sum += i.used_material_items.size }

    unless saled_count + used_count == 0
      errors.add_to_base "Cannot delete the purchase orders saled products or used materials."
      false
    end
  end

  def total_product_weight
    purchase_order_items.inject(0.0) { |sum, item| sum += item.total_weight }
  end

  def total_material_weight
    material_items.inject(0.0) { |sum, item| sum += item.total_weight }
  end

  def total_weight
    total_product_weight + total_material_weight
  end

  def total_product_price
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

  def total_material_price
    items = material_items.select { |item| item.item_price }

    if items.empty?
      # 如果所有 material_items 的 price 都没有，返回 0.0
      return 0.0
    else
      # 只要 material_items 中有 price，就求和
      # 一个特殊情况是所有 price 为 0，从而和为 0
      items.inject(0.0) { |sum, item| sum + item.total_price }
    end
  end

  def total_price
    total_product_price + total_material_price
  end

  def total_price_with_postage
    total_price + postage
  end

  def postage_percentage
    if total_price == 0.0
      0.0
    else
      postage / total_price
    end
  end

  def cost_price_rate
    if total_price_with_postage == 0.0 or total_cost.nil?
      0.0
    else
      total_cost / total_price_with_postage
    end
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

  def new_material_item_attributes=(material_item_attributes)
    material_item_attributes.each do |attributes|
      attributes[:purchase_order_id] = 0
      material_items.build(attributes)
    end
  end

  def existing_material_item_attributes=(material_item_attributes)
    material_items.reject(&:new_record?).each do |material_item|
      attributes = material_item_attributes[material_item.id.to_s]
      if attributes
        material_item.attributes = attributes
      else
        material_items.delete(material_item)
      end
    end
  end

  protected

  def save_purchase_order_items_and_material_items
    purchase_order_items.each { |item| item.save(false) }
    material_items.each { |item| item.save(false) }
  end

  def calculate_purchase_order_item_costs
    return if total_cost.nil? or purchase_order_items.size == 0 or total_price.nil?

    # 更新成品的价格
    purchase_order_items.each do |item|
      # 没有 price 就没有 cost
      next if item.unit_price.nil?

      if total_price_with_postage == 0.0
        # total_weight 和 total_price_with_postage 在公式中作为分母
        # 1. total_weight 不会为 0，只有所有 item 都没有 unit_price 的
        #    情况下，total_weight 才为 0，而这种情况代码不会运行到这里
        # 2. 如果所有 item 的 unit_price 和运费为 0（如赠
        #    品），total_price_with_postage 为 0
        item.unit_cost = 0.0
      else
        item.unit_cost = (item.unit_price + postage *  item.unit_weight / total_weight) *
          total_cost / total_price_with_postage
      end
      item.save
    end

    # 更新原料的价格
    material_items.each do |item|
      next if item.item_price.nil?
      if total_price_with_postage == 0.0
        item.item_cost = 0.0
      else
        item.item_cost = (item.item_price + postage *  item.item_weight / total_weight) *
          total_cost / total_price_with_postage
      end
      item.save
    end
  end
end
