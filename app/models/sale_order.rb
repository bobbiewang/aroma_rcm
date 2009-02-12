class SaleOrder < ActiveRecord::Base
  has_many :sale_order_items
  belongs_to :customer

  after_update :save_sale_order_items

  def new_sale_order_item_attributes=(sale_order_item_attributes)
    sale_order_item_attributes.each do |attributes|
      attributes[:sale_order_id] = 0
      sale_order_items.build(attributes)
    end
  end

  def existing_sale_order_item_attributes=(sale_order_item_attributes)
    sale_order_items.reject(&:new_record?).each do |sale_order_item|
      attributes = sale_order_item_attributes[sale_order_item.id.to_s]
      if attributes
        sale_order_item.attributes = attributes
      else
        sale_order_items.delete(sale_order_item)
      end
    end
  end

  protected

  def save_sale_order_items
    sale_order_items.each { |item| item.save(false) }
  end
end
