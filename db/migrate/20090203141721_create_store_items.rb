class CreateStoreItems < ActiveRecord::Migration
  def self.up
    create_table :store_items do |t|
      t.integer :purchase_order_id
      t.decimal :buying_price
      t.decimal :cost
      t.decimal :cost_per_ml
      t.decimal :cost_per_drop

      t.timestamps
    end
  end

  def self.down
    drop_table :store_items
  end
end
