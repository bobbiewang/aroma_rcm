class StoreController < ApplicationController
  def purchase
    @vendors = Vendor.find(:all, :conditions => ["active = ?", true])
  end

  def sale
    @items = PurchaseOrderItem.find(:all)
  end
end
