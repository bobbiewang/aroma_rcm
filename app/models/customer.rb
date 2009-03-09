class Customer < ActiveRecord::Base
  include Comparable

  has_many :sale_orders, :order => 'saled_at'

  def <=>(other)
    utf8_2_gbk(name) <=> utf8_2_gbk(other.name)
  end

  def total_expense
    sale_orders.inject(0) { |sum, i| sum += i.total_price }
  end
end
