# -*- coding: utf-8 -*-
class VendorProduct < ActiveRecord::Base
  validates_presence_of :title, :vendor_id, :active
  validates_uniqueness_of :title, :case_sensitive => false, :scope => "vendor_id"
  validates_numericality_of :vendor_id
  validates_numericality_of :capacity, :allow_nil => true
  validates_numericality_of :price, :allow_nil => true

  # TODO 创建 title 失败 3ml Chamomile Roman，重定向后找不到 vendors
  # TODO 在 conroller 中测试 title 在 group 中的 uniqueness

  has_many :purchase_order_items
  has_many :material_items
  belongs_to :vendor
  belongs_to :measuring_unit

  def postage_weight
    # 目前产品没有重量的概念，用容量模拟重量。没有容量的产品算 1ml（贵重物品算 500ml）
    # 因为 weight 是用于分担运费计算 cost，所以如果某个产品没有
    # unit_price，那么 weight 也算 0，从而不分担运费
    return 0 if price.nil?

    if capacity.nil?
      if price > 10
        500
      else
        1
      end
    else
      capacity
    end

  end

  def purchased_count
    purchase_order_items.inject(0) { |sum,i| sum += i.quantity }
  end

  def saled_count
    purchase_order_items.inject(0) do |sum, p_item|
      sum += p_item.sale_order_items.inject(0) do |sub_sum, s_item|
        sub_sum += s_item.quantity
      end
    end
  end

  def using_count
    material_items.inject(0) { |sum,i| sum += i.quantity }
  end

  def left_count
    purchased_count - saled_count
  end
end
