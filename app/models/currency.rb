class Currency < ActiveRecord::Base
  validates_presence_of :full_name, :iso_code, :symbol
  validates_uniqueness_of :full_name, :iso_code
end
