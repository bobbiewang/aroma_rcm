class StoreProductItem < ActiveRecord::Base
  validates_presence_of :store_product_id, :quantity

  has_many :used_material_items
  belongs_to :store_product

  def new_used_material_item_attributes=(used_material_item_attributes)
    used_material_item_attributes.each do |attributes|
      attributes[:store_product_item_id] = 0
      used_material_items.build(attributes)
    end
  end

  def existing_used_material_item_attributes=(used_material_item_attributes)
    used_material_items.reject(&:new_record?).each do |used_material_item|
      attributes = used_material_item_attributes[used_material_item.id.to_s]
      if attributes
        used_material_item.attributes = attributes
      else
        used_material_items.delete(used_material_item)
      end
    end
  end
end
