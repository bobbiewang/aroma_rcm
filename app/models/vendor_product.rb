class VendorProduct < ActiveRecord::Base
  validates_presence_of :title, :vendor_id, :active
  validates_uniqueness_of :title, :case_sensitive => false, :scope => "vendor_id"
  validates_numericality_of :vendor_id
  validates_numericality_of :capacity, :allow_nil => true
  validates_numericality_of :price, :allow_nil => true

  # TODO 创建 title 失败 3ml Chamomile Roman，重定向后找不到 vendors
  # TODO 在 conroller 中测试 title 在 group 中的 uniqueness

  belongs_to :vendor
end
