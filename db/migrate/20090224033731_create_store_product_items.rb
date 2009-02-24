class CreateStoreProductItems < ActiveRecord::Migration
  def self.up
    create_table :store_product_items do |t|
      t.integer :store_product_id, :null => false
      t.integer :quantity, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :store_product_items
  end
end
