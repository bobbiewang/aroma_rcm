class VendorProduct < ActiveRecord::Base
  validates_presence_of :title, :vendor_id, :active
  validates_uniqueness_of :title
  validates_numericality_of :vendor_id
  validates_numericality_of :capacity, :allow_nil => true
  validates_numericality_of :price, :allow_nil => true

  belongs_to :vendor
end
