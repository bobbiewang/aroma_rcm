class SaledStoreProductItem < ActiveRecord::Base
  validates_numericality_of :sale_order_id, :store_product_item_id, :item_price, :quantity

  belongs_to :sale_order
  belongs_to :store_product_item

  def self.total_saled_price
    SaledStoreProductItem.find(:all).inject(0) { |sum,i| sum += i.total_price }
  end

  def item_cost
    store_product_item.item_cost
  end

  def item_profit
    item_price - item_cost
  end

  def total_cost
    quantity * item_cost
  end

  def total_price
    quantity * item_price
  end

  def total_profit
    quantity * item_profit
  end
end
