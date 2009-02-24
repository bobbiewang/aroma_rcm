class UsedMaterialItem < ActiveRecord::Base
  validates_presence_of :material_item_id, :store_product_item_id, :amount
  validates_numericality_of :material_item_id, :store_product_item_id, :amount

  belongs_to :material_item
  belongs_to :store_product_item
end
