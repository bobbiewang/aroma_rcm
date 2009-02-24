class StoreProduct < ActiveRecord::Base
  validates_presence_of :title, :active
  validates_uniqueness_of :title, :case_sensitive => false
  validates_numericality_of :capacity, :allow_nil => true
  validates_numericality_of :price, :allow_nil => true

  belongs_to :measuring_unit
end
