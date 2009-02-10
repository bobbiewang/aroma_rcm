class CreatePurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :purchase_orders do |t|
      t.integer :vendor_id, :null => false
      t.date :purchased_at
      t.date :arrived_at
      t.decimal :postage, :precision => 10, :scale => 4, :default => 0.0
      t.decimal :total_cost, :precision => 13, :scale => 4
      t.text :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_orders
  end
end
