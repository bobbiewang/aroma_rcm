class CreateMaterialItems < ActiveRecord::Migration
  def self.up
    create_table :material_items do |t|
      t.integer :purchase_order_id, :null => false
      t.integer :vendor_product_id, :null => false
      t.decimal :item_price, :precision => 10, :scale => 4
      t.decimal :item_cost, :precision => 10, :scale => 4
      t.integer :quantity, :null => false
      t.boolean :usedup, :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :material_items
  end
end
