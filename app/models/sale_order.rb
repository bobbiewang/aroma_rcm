class SaleOrder < ActiveRecord::Base
  validate :sale_order_items_must_be_valid

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

  def total_cost
    sale_order_items.inject(0.0) { |sum, item| sum + item.total_cost }
  end

  def total_cost_with_postage
    sale_order_items.inject(0.0) { |sum, item| sum + item.total_cost } + postage
  end

  def total_price
    sale_order_items.inject(0.0) { |sum, item| sum + item.total_price }
  end

  def total_profit
    sale_order_items.inject(0.0) { |sum, item| sum + item.total_profit } - postage
  end

  protected

  def sale_order_items_must_be_valid
    sale_order_items.each do |item|
      errors.add_to_base(item.errors.full_messages) unless item.valid?
    end
  end

  def save_sale_order_items
    sale_order_items.each { |item| item.save(false) }
  end
end
