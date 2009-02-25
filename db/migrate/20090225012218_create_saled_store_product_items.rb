class CreateSaledStoreProductItems < ActiveRecord::Migration
  def self.up
    create_table :saled_store_product_items do |t|
      t.integer :sale_order_id, :null => false
      t.integer :store_product_item_id, :null => false
      t.decimal :item_price, :null => false, :precision => 10, :scale => 4
      t.integer :quantity, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :saled_store_product_items
  end
end
