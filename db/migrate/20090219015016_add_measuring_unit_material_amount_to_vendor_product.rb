class AddMeasuringUnitMaterialAmountToVendorProduct < ActiveRecord::Migration
  def self.up
    add_column :vendor_products, :measuring_unit_id, :integer, :null => false
    add_column :vendor_products, :material_amount, :integer, :null => false
  end

  def self.down
    remove_column :vendor_products, :measuring_unit_id
    remove_column :vendor_products, :material_amount
  end
end
