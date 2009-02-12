class SaleOrderItem < ActiveRecord::Base
  belongs_to :sale_order
  belongs_to :purchase_order_item

  validate_on_create :should_not_exceed_available_quantity_on_create

  def should_not_exceed_available_quantity_on_create
    return if purchase_order_item.avail_quantity == -1

    if quantity > purchase_order_item.avail_quantity
      errors.add(:quantity, "exceeds available amount.")
    end
  end

  def profit
    quantity * (unit_price - unit_cost)
  end
end
