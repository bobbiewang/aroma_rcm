class Customer < ActiveRecord::Base
  has_many :sale_orders, :order => 'saled_at'

  def total_expense
    sale_orders.inject(0) { |sum, i| sum += i.total_price }
  end
end
