class CreateStoreProducts < ActiveRecord::Migration
  def self.up
    create_table :store_products do |t|
      t.string :title, :null => false
      t.integer :capacity
      t.decimal :price, :precision => 10, :scale => 4
      t.boolean :active, :null => false, :default => true
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :store_products
  end
end
