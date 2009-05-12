class ReportsController < ApplicationController
  def monthly
    year = Time.now.year
    month = Time.now.month

    spendings = 1.upto(month).map do |m|
      start_date = Time.mktime(year, m)
      end_date = Time.mktime(year, m + 1)
      orders = PurchaseOrder.find(:all,
                                  :conditions => ['purchased_at >= ? and purchased_at <= ?',
                                                  start_date, end_date])
      orders.inject(0) { |sum, o| sum += o.total_cost }
    end

    incomes = 1.upto(month).map do |m|
      start_date = Time.mktime(year, m)
      end_date = Time.mktime(year, m + 1)
      orders = SaleOrder.find(:all,
                              :conditions => ['saled_at >= ? and saled_at <= ?',
                                              start_date, end_date])
      orders.inject(0) { |sum, o| sum += o.total_price }
    end

    render :text => "<pre>Purchase:\n#{spendings.to_yaml}\nSale:\n#{incomes.to_yaml}</pre>"
  end
end
