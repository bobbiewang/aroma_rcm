# -*- coding: undecided -*-
require 'iconv'

class MaterialItem < ActiveRecord::Base
  validates_presence_of :purchase_order_id, :vendor_product_id, :quantity
  validates_numericality_of :purchase_order_id, :vendor_product_id, :quantity
  validates_numericality_of :item_price, :allow_nil => true
  validates_numericality_of :item_cost, :allow_nil => true

  belongs_to :purchase_order
  belongs_to :vendor_product
  has_many :used_material_items

  def self.avail_items
    conv = Iconv.new("GBK", "utf-8")

    items = MaterialItem.find(:all, :conditions => ["usedup =? ", false])
    items.sort do |x, y|
      conv.iconv(x.title) <=> conv.iconv(y.title)
    end
  end

  def title
    vendor_product.title
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
