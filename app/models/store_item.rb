class StoreItem < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :vendor_product

  validates_presence_of :purchase_order_id,
                        :message => "Missing purchase_order_id"
  validates_presence_of :vendor_product_id,
                        :message => "Missing vendor_product_id"

  def saled_quantity
    0
  end
end
