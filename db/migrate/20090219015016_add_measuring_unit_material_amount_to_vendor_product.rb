class AddMeasuringUnitMaterialAmountToVendorProduct < ActiveRecord::Migration
  def self.up
    add_column :vendor_products, :measuring_unit_id, :integer, :null => false
    add_column :vendor_products, :material_amount, :integer, :null => false

    VendorProduct.find(:all).each do |product|
      if product.capacity.nil?
        product.update_attributes(:measuring_unit_id => 1,
                                  :material_amount => 1)
      elsif product.capacity >= 100
        product.update_attributes(:measuring_unit_id => 2,
                                  :material_amount => product.capacity)
      else
        product.update_attributes(:measuring_unit_id => 3,
                                  :material_amount => product.capacity * 20)
      end
    end
  end

  def self.down
    remove_column :vendor_products, :measuring_unit_id
    remove_column :vendor_products, :material_amount
  end
end
