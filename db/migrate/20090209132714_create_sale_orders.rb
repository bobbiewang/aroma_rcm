class CreateSaleOrders < ActiveRecord::Migration
  def self.up
    create_table :sale_orders do |t|
      t.integer :customer_id, :null => false
      t.date :sale_date, :null => false
      t.decimal :postage, :null => false, :precision => 10, :scale => 4
      t.text :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :sale_orders
  end
end
