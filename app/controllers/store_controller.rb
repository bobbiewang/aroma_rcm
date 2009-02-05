class StoreController < ApplicationController
  def purchase
    @vendors = Vendor.find(:all)
  end
end
