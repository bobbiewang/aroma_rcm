class CreatePurchaseOrderItems < ActiveRecord::Migration
  def self.up
    create_table :purchase_order_items do |t|
      t.integer :purchase_order_id, :null => false
      t.integer :vendor_product_id, :null => false
      t.decimal :unit_price, :null => false, :precision => 8, :scale => 2
      t.decimal :unit_cost, :precision => 8, :scale => 2
      t.decimal :ml_cost, :precision => 8, :scale => 2
      t.decimal :drop_cost, :precision => 8, :scale => 2
      t.integer :quantity, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_order_items
  end
end
