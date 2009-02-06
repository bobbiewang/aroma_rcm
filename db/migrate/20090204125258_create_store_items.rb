class CreateStoreItems < ActiveRecord::Migration
  def self.up
    create_table :store_items do |t|
      t.integer :purchase_order_id, :null => false
      t.integer :vendor_product_id, :null => false
      t.decimal :cost_per_unit, :precision => 8, :scale => 2
      t.decimal :cost_per_ml, :precision => 8, :scale => 2
      t.decimal :cost_per_drop, :precision => 8, :scale => 2
      t.integer :quantity
      t.integer :sale_quantity
      t.integer :use_quantity
      t.integer :saled_quantity
      t.integer :used_quantity
      t.integer :archived_quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :store_items
  end
end
