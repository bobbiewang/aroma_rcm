class SaleOrderItem < ActiveRecord::Base
  belongs_to :sale_order
  belongs_to :purchase_order_item
end
