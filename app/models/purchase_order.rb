class PurchaseOrder < ActiveRecord::Base
  belongs_to :vendor
  has_many :store_items

  def new_store_item_attributes=(store_item_attributes)
    store_item_attributes.each do |attributes|
      store_items.build(attributes)
    end
  end
end
