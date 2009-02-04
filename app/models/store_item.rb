class StoreItem < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :vendor_product

  validates_presence_of :purchase_order_id
  validates_presence_of :vendor_product_id
end
