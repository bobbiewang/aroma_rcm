class CreatePurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :purchase_orders do |t|
      t.integer :vendor_id
      t.date :purchase_date
      t.date :arrival_date
      t.decimal :postage
      t.decimal :total_cost

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_orders
  end
end
