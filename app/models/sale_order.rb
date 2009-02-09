class SaleOrder < ActiveRecord::Base
  has_many :sale_order_items

  def new_sale_order_item_attributes=(sale_order_item_attributes)
    sale_order_item_attributes.each do |attributes|
      attributes[:sale_order_id] = 0
      sale_order_items.build(attributes)
    end
  end
end
