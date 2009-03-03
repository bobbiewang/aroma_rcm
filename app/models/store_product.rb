class StoreProduct < ActiveRecord::Base
  validates_presence_of :title, :active
  validates_uniqueness_of :title, :case_sensitive => false
  validates_numericality_of :capacity, :allow_nil => true
  validates_numericality_of :price, :allow_nil => true

  has_many :store_product_items, :order => "produced_at"
  belongs_to :measuring_unit

  def producing_count
    store_product_items.inject(0) { |sum, i| sum += i.quantity }
  end

  def total_cost
    store_product_items.inject(0) { |sum, i| sum += i.total_cost }
  end

  def total_price
    store_product_items.inject(0) { |sum, i| sum += i.total_price }
  end

  def total_profit
    store_product_items.inject(0) { |sum, i| sum += i.total_profit }
  end

  def average_cost
    return 0.0 if producing_count == 0
    total_cost / producing_count
  end

  def average_price
    return 0.0 if producing_count == 0
    total_price / producing_count
  end

  def average_profit
    return 0.0 if producing_count == 0
    total_profit / producing_count
  end
end
