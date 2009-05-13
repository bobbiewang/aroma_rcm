# -*- coding: undecided -*-
class ReportsController < ApplicationController
  def monthly
    year = Time.now.year
    month = Time.now.month

    arr_data = 1.upto(month).map do |m|
      start_date = Time.mktime(year, m)
      end_date = Time.mktime(year, m + 1)
      purchased_orders = PurchaseOrder.find(:all,
                                            :conditions => ['purchased_at >= ? and purchased_at <= ?',
                                                            start_date, end_date])
      sale_orders = SaleOrder.find(:all,
                                   :conditions => ['saled_at >= ? and saled_at <= ?',
                                                   start_date, end_date])

      [start_date.strftime("%b"),
       purchased_orders.inject(0) { |sum, o| sum += o.total_cost },
       sale_orders.inject(0) { |sum, o| sum += o.total_price }]
    end

    @str_xml = ms_array_data(arr_data, 'Monthly Spending/Income')
  end

  private

  def ms_array_data(arr_data, caption)
    str_xml = ''

    xml = ::Builder::XmlMarkup.new(:target => str_xml)
    xml.graph(:caption => caption, :numberPrefix => '', :formatNumberScale => '2',
              :rotateValues => '1', :placeValuesInside => '1', :decimalPrecision => '0') do
      # Iterate through the array to create the <category> tags within <categories>
      xml.categories do
        for item in arr_data
          xml.category(:name => item[0])
        end
      end

      # Iterate through the array to create the <set> tags within dataset for series 'Current Year'
      xml.dataset(:seriesName => 'Spending',:color => 'AFD8F8') do
        for item in arr_data
          xml.set(:value => item[1])
        end
      end

      # Iterate through the array to create the <set> tags within dataset for series 'Previous Year'
      xml.dataset(:seriesName => 'Income',:color => 'F6BD0F') do
        for item in arr_data
          xml.set(:value => item[2])
        end
      end
    end

    str_xml
  end
end
