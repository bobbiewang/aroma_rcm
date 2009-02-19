class MeasuringUnit < ActiveRecord::Base
  validates_presence_of :full_name, :abbr_name, :precision
  validates_numericality_of :precision
  validates_uniqueness_of :full_name, :abbr_name
end
