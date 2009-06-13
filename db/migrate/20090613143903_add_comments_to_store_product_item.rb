class AddCommentsToStoreProductItem < ActiveRecord::Migration
  def self.up
    add_column :store_product_items, :comments, :text
  end

  def self.down
    remove_column :store_product_items, :comments
  end
end
