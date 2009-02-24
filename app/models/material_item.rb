class MaterialItem < ActiveRecord::Base
  validates_presence_of :purchase_order_id, :vendor_product_id, :quantity
  validates_numericality_of :purchase_order_id, :vendor_product_id, :quantity
  validates_numericality_of :item_price, :allow_nil => true
  validates_numericality_of :item_cost, :allow_nil => true

  belongs_to :purchase_order
  belongs_to :vendor_product

  def title
    vendor_product.title
  end

  def total_price
    item_price * quantity
  end

  def total_cost
    item_cost * quantity
  end

  def unit_cost
    item_cost / vendor_product.material_amount
  end

  def total_material_amount
    quantity * vendor_product.material_amount
  end

  def item_weight
    # 目前产品没有重量的概念，用容量模拟重量。没有容量的产品算 1ml（贵重物品算 500ml）
    # 因为 weight 是用于分担运费计算 cost，所以如果某个产品没有
    # item_price，那么 weight 也算 0，从而不分担运费
    return 0 if item_price.nil?

    capacity = vendor_product.capacity
    if capacity.nil?
      if item_price > 10
        500
      else
        1
      end
    else
      capacity
    end
  end
end
