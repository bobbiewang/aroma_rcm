class UsedMaterialItem < ActiveRecord::Base
  validates_presence_of :material_item_id, :amount
  validates_numericality_of :material_item_id, :amount
end
