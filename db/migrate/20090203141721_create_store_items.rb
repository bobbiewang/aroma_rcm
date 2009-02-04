class CreateStoreItems < ActiveRecord::Migration
  def self.up
    create_table :store_items do |t|
      t.integer :purchase_order_id, :null => false
      t.decimal :buying_price, :null => false, :precision => 8, :scale => 2
      t.decimal :cost, :precision => 8, :scale => 2
      t.decimal :cost_per_ml, :precision => 8, :scale => 2
      t.decimal :cost_per_drop, :precision => 8, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :store_items
  end
end
