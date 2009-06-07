# -*- coding: undecided -*-
class ReportsController < ApplicationController
  def monthly
    date = Time.mktime(2008, 10)
    end_date = Time.now.end_of_month

    arr_data = []
    while date < end_date
      arr_data << [ date.strftime("%Y %b"),
                    PurchaseOrder.monthly_cost(date),
                    SaleOrder.monthly_price(date) ]
      date = date.months_since(1)
    end

    @si_xml = ms_array_data(arr_data, 'Monthly Spending/Income')

    total_spending, total_income = 0, 0
    arr_data = arr_data.map do |items|
      total_spending += items[1]
      total_income   += items[2]
      total_profit    = total_income - total_spending
      [items.first, total_profit, total_profit - 21680.0]
    end

    @tp_xml = ms_array_data(arr_data, 'Total Profit')
  end

  private

  def ss_array_data(arr_data, caption)
    xml = Builder::XmlMarkup.new
    xml.graph(:caption => caption, :numberPrefix => '', :formatNumberScale => '2',
              :decimalPrecision => '0') do
      for item in arr_data
        xml.set(:name=>item[0], :value=>item[1])
        end
    end
  end

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

      # Iterate through the array to create the <set> tags within dataset for 1st series
      xml.dataset(:seriesName => 'Spending',:color => 'AFD8F8') do
        for item in arr_data
          xml.set(:value => item[1])
        end
      end

      # Iterate through the array to create the <set> tags within dataset for 2nd series
      xml.dataset(:seriesName => 'Income',:color => 'F6BD0F') do
        for item in arr_data
          xml.set(:value => item[2])
        end
      end
    end

    str_xml
  end
end
