class RemoveUnitCostFromSaleOrderItems < ActiveRecord::Migration
  def self.up
    remove_column :sale_order_items, :unit_cost
  end

  def self.down
    add_column :sale_order_items, :unit_cost, :decimal, :null => false, :precision => 10, :scale => 4
  end
end
