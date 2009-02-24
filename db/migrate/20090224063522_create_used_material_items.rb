class CreateUsedMaterialItems < ActiveRecord::Migration
  def self.up
    create_table :used_material_items do |t|
      t.integer :material_item_id, :null => false
      t.integer :store_product_item_id, :null => false
      t.integer :amount, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :used_material_items
  end
end
