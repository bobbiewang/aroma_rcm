# -*- coding: utf-8 -*-
class CreateVendorProducts < ActiveRecord::Migration
  def self.up
    create_table :vendor_products do |t|
      t.string  :title, :null => false
      t.integer :vendor_id, :null => false
      t.integer :capacity
      t.decimal :price, :null => false, :precision => 8, :scale => 2

      t.timestamps
    end

    VendorProduct.create(:title     => "10ml 薰衣草",
                         :vendor_id => 1,
                         :capacity  => 10,
                         :price     => 2.00)
    VendorProduct.create(:title     => "2ml Rose",
                         :vendor_id => 2,
                         :capacity  => 2,
                         :price     => 15.00)
    VendorProduct.create(:title     => "10ml Chamomile",
                         :vendor_id => 3,
                         :capacity  => 10,
                         :price     => 7.00)
  end

  def self.down
    drop_table :vendor_products
  end
end
