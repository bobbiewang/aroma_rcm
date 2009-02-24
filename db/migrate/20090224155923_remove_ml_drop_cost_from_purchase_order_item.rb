class RemoveMlDropCostFromPurchaseOrderItem < ActiveRecord::Migration
  def self.up
    remove_column :purchase_order_items, :ml_cost
    remove_column :purchase_order_items, :drop_cost
  end

  def self.down
    add_column :purchase_order_items, :ml_cost, :precision => 10, :scale => 4
    add_column :purchase_order_items, :drop_cost, :precision => 10, :scale => 4
  end
end
