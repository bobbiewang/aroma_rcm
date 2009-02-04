class CreatePurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :purchase_orders do |t|
      t.integer :vendor_id, :null => false
      t.date :purchase_date
      t.date :arrival_date
      t.decimal :postage, :precision => 8, :scale => 2
      t.decimal :total_cost, :precision => 11, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_orders
  end
end
