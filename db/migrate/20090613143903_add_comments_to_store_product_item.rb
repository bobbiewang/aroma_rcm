class AddCommentsToStoreProductItem < ActiveRecord::Migration
  def self.up
    new_vendor = Vendor.new(:full_name   => "香弥谷",
                            :abbr_name   => "香弥谷",
                            :currency_id => 1,
                            :active      => true)
    new_vendor.save!
    new_id = new_vendor.id
    Vendor.find(3).vendor_products.each do |p|
      VendorProduct.create!(:title => p.title,
                           :vendor_id => new_id,
                           :capacity => p.capacity,
                           :price => p.price * 11.5 * 1.3,
                           :active => true,
                           :description => p.description,
                           :measuring_unit_id => p.measuring_unit_id,
                           :material_amount => p.material_amount)
    end
    add_column :store_product_items, :comments, :text
  end

  def self.down
    remove_column :store_product_items, :comments
  end
end
