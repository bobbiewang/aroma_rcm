class UsedMaterialItem < ActiveRecord::Base
  validates_presence_of :material_item_id, :store_product_item_id, :amount
  validates_numericality_of :material_item_id, :store_product_item_id, :amount

  belongs_to :material_item
  belongs_to :store_product_item

  def self.total_used_cost
    UsedMaterialItem.find(:all).inject(0) { |sum,i| sum += i.total_cost }
  end

  def unit_cost
    material_item.unit_cost
  end

  def total_cost
    amount * unit_cost
  end
end
