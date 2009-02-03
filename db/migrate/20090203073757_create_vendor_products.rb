class CreateVendorProducts < ActiveRecord::Migration
  def self.up
    create_table :vendor_products do |t|
      t.string :title
      t.integer :vendor_id
      t.integer :capacity
      t.decimal :price

      t.timestamps
    end
  end

  def self.down
    drop_table :vendor_products
  end
end
