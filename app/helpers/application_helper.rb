# -*- coding: utf-8 -*-
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def number_to_cny(number)
    number_to_currency(number, :unit => "￥")
  end

  def number_to_per_unit(number, symbol, unit)
    return "" if number.blank?
    number_to_currency(number, :unit => symbol) + "/#{unit}"
  end

  def number_to_quantity(number)
    if number == -1
      "-"
    else
      number
    end
  end

  def boolean_to_yesno(bool)
    bool ? 'YES' : 'NO'
  end
end
