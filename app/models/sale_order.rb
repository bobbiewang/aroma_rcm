class SaleOrder < ActiveRecord::Base
  has_many :sale_order_items
end
