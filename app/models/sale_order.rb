class SaleOrder < ActiveRecord::Base
  validate :sale_order_items_must_be_valid

  has_many :sale_order_items, :dependent => :destroy
  has_many :saled_store_product_items, :dependent => :destroy
  belongs_to :customer

  after_update :save_sale_order_items_and_saled_store_product_items

  def self.total_price
    SaleOrder.find(:all).inject(0.0) { |sum, item| sum += item.total_price }
  end

  def self.total_profit
    SaleOrder.find(:all).inject(0.0) { |sum, item| sum += item.total_profit }
  end

  def self.monthly_price(date)
    start_date = date.beginning_of_month
    end_date = date.end_of_month
    orders = SaleOrder.find(:all, :conditions => ['saled_at >= ? and saled_at <= ?',
                                                  start_date, end_date])
    orders.inject(0) { |sum, o| sum += o.total_price }
  end

  def new_vendor_product_item_attributes=(vendor_product_item_attributes)
    vendor_product_item_attributes.each do |attributes|
      attributes[:sale_order_id] = 0
      sale_order_items.build(attributes)
    end
  end

  def existing_vendor_product_item_attributes=(vendor_product_item_attributes)
    sale_order_items.reject(&:new_record?).each do |vendor_product_item|
      attributes = vendor_product_item_attributes[vendor_product_item.id.to_s]
      if attributes
        vendor_product_item.attributes = attributes
      else
        sale_order_items.delete(vendor_product_item)
      end
    end
  end

  def new_store_product_item_attributes=(store_product_item_attributes)
    store_product_item_attributes.each do |attributes|
      attributes[:sale_order_id] = 0
      saled_store_product_items.build(attributes)
    end
  end

  def existing_store_product_item_attributes=(store_product_item_attributes)
    saled_store_product_items.reject(&:new_record?).each do |store_product_item|
      attributes = store_product_item_attributes[store_product_item.id.to_s]
      if attributes
        store_product_item.attributes = attributes
      else
        saled_store_product_items.delete(store_product_item)
      end
    end
  end


  def total_vendor_product_cost
    sale_order_items.inject(0.0) { |sum, item| sum + item.total_cost }
  end

  def total_store_product_cost
    saled_store_product_items.inject(0.0) { |sum, item| sum + item.total_cost }
  end

  def total_cost
    total_vendor_product_cost + total_store_product_cost
  end

  def total_cost_with_postage
    total_cost + postage
  end

  def total_vendor_product_price
    sale_order_items.inject(0.0) { |sum, item| sum + item.total_price }
  end

  def total_store_product_price
    saled_store_product_items.inject(0.0) { |sum, item| sum + item.total_price }
  end

  def total_price
    total_vendor_product_price + total_store_product_price
  end

  def total_profit
    total_price - total_cost_with_postage
  end

  def profit_rate
    total_profit / total_price
  end

  protected


  def sale_order_items_must_be_valid
    sale_order_items.each do |item|
      errors.add_to_base(item.errors.full_messages) unless item.valid?
    end
  end

  def save_sale_order_items_and_saled_store_product_items
    sale_order_items.each { |item| item.save(false) }
    saled_store_product_items.each { |item| item.save(false) }
  end
end
