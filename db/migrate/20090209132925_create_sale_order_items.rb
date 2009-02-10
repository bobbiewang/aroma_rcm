class CreateSaleOrderItems < ActiveRecord::Migration
  def self.up
    create_table :sale_order_items do |t|
      t.integer :sale_order_id, :null => false
      t.integer :purchase_order_item_id, :null => false
      t.decimal :unit_cost, :null => false, :precision => 10, :scale => 4
      t.decimal :unit_price, :null => false, :precision => 10, :scale => 4
      t.integer :quantity, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :sale_order_items
  end
end
