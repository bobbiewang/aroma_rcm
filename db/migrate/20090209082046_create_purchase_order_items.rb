class CreatePurchaseOrderItems < ActiveRecord::Migration
  def self.up
    create_table :purchase_order_items do |t|
      t.integer :purchase_order_id, :null => false
      t.integer :vendor_product_id, :null => false
      t.decimal :unit_price, :precision => 10, :scale => 4
      t.decimal :unit_cost, :precision => 10, :scale => 4
      t.decimal :ml_cost, :precision => 10, :scale => 4
      t.decimal :drop_cost, :precision => 10, :scale => 4
      t.integer :quantity, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_order_items
  end
end
