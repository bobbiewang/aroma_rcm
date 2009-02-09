class VendorProduct < ActiveRecord::Base
  validates_presence_of :title, :vendor_id, :price, :active
  validates_uniqueness_of :title
  validates_numericality_of :vendor_id, :capacity, :price

  belongs_to :vendor
end
