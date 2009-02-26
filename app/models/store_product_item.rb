class StoreProductItem < ActiveRecord::Base
  validates_presence_of :store_product_id, :quantity

  has_many :used_material_items
  belongs_to :store_product
  has_many :saled_store_product_items

  def self.avail_items
    conv = Iconv.new("GBK", "utf-8")

    items = StoreProductItem.find(:all).select { |item| item.avail? }
    items.sort do |x, y|
      if x.store_product.title != y.store_product.title
        conv.iconv(x.store_product.title) <=> conv.iconv(y.store_product.title)
      else
        x.produced_at <=> y.produced_at
      end
    end
  end

  def title
    store_product.title
  end

  def saled_quantity
    saled_store_product_items.inject(0) { |sum, item| sum += item.quantity }
  end

  def avail_quantity
    quantity - saled_quantity
  end

  def avail?
    avail_quantity > 0
  end

  def item_cost
    total_cost / quantity
  end

  def total_cost
    used_material_items.inject(0.0) do |sum, item|
      sum += item.amount * item.material_item.unit_cost
    end
  end

  def new_used_material_item_attributes=(used_material_item_attributes)
    used_material_item_attributes.each do |attributes|
      attributes[:store_product_item_id] = 0
      used_material_items.build(attributes)
    end
  end

  def existing_used_material_item_attributes=(used_material_item_attributes)
    used_material_items.reject(&:new_record?).each do |used_material_item|
      attributes = used_material_item_attributes[used_material_item.id.to_s]
      if attributes
        used_material_item.attributes = attributes
      else
        used_material_items.delete(used_material_item)
      end
    end
  end
end
