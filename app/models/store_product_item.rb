class StoreProductItem < ActiveRecord::Base
  validates_presence_of :store_product_id, :quantity
end
