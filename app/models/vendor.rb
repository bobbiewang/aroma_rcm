class Vendor < ActiveRecord::Base
  validates_presence_of :full_name, :currency_id
  validates_uniqueness_of :full_name, :abbr_name

  belongs_to :currency
  has_many :vendor_products, :order => "title"
end
