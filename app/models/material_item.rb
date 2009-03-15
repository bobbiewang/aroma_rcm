# -*- coding: utf-8 -*-

class MaterialItem < ActiveRecord::Base
  validates_presence_of :purchase_order_id, :vendor_product_id, :quantity
  validates_numericality_of :purchase_order_id, :vendor_product_id, :quantity
  validates_numericality_of :item_price, :allow_nil => true
  validates_numericality_of :item_cost, :allow_nil => true

  before_destroy :validates_no_dependents

  belongs_to :purchase_order
  belongs_to :vendor_product
  has_many :used_material_items

  def validates_no_dependents
    unless used_material_items.count == 0
      errors.add_to_base "Cannot delete this material item, as it is in use."
      false
    end
  end

  def self.avail_items
    items = MaterialItem.find(:all, :conditions => ["usedup =? ", false])
    items.sort do |x, y|
      if x.vendor_product.vendor.id != y.vendor_product.vendor.id
        x.vendor_product.vendor.id <=> y.vendor_product.vendor.id
      else
        utf8_2_gbk(x.title) <=> utf8_2_gbk(y.title)
      end
    end
  end

  def self.usedup_items
    items = MaterialItem.find(:all, :conditions => ["usedup =? ", true])
    items.sort do |x, y|
      if x.vendor_product.vendor.id != y.vendor_product.vendor.id
        x.vendor_product.vendor.id <=> y.vendor_product.vendor.id
      else
        utf8_2_gbk(x.title) <=> utf8_2_gbk(y.title)
      end
    end
  end

  def self.total_cost
    MaterialItem.find(:all).inject(0.0) { |sum, i| sum += i.total_cost }
  end

  def self.total_in_use_cost
    items = MaterialItem.find(:all, :conditions => ["usedup =? ", false])
    items.inject(0) { |sum, i| sum += i.total_cost }
  end

  def title
    vendor_product.title
  end

  def amount
    quantity * vendor_product.material_amount
  end

  def measuring_unit
    vendor_product.measuring_unit.abbr_name
  end
  def vendor_title_usage
    "#{vendor_product.vendor.abbr_name} - #{title}  " +
      "【#{total_avail_material_amount}/#{total_material_amount}】"
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

  def total_used_material_amount
    used_material_items.inject(0) { |sum, i| sum += i.amount }
  end

  def total_avail_material_amount
    total_material_amount - total_used_material_amount
  end

  def item_weight
    vendor_product.postage_weight
  end

  def total_weight
    quantity * item_weight
  end
end
