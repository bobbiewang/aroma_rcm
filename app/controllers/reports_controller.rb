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
