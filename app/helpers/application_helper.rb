# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def number_to_per_unit(number, symbol, unit)
    return "" if number.blank?
    number_to_currency(number, :unit => symbol) + "/#{unit}"
  end
end
