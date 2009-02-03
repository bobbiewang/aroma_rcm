class Vendor < ActiveRecord::Base
  belongs_to :currency
  has_many :vendor_products
end
