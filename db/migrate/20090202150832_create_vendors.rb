# -*- coding: utf-8 -*-
class CreateVendors < ActiveRecord::Migration
  def self.up
    create_table :vendors do |t|
      t.string  :full_name, :null => false
      t.string  :abbr_name, :limit => 32
      t.integer :currency_id, :null => false
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end

    Vendor.create(:full_name   => "欧芳（天津）日化有限公司",
                  :abbr_name   => "OF",
                  :currency_id => 1,
                  :active      => false)
    Vendor.create(:full_name   => "Shirley Price",
                  :abbr_name   => "SP",
                  :currency_id => 2,
                  :active      => true)
    Vendor.create(:full_name   => "Penny Price",
                  :abbr_name   => "PP",
                  :currency_id => 2,
                  :active      => true)
  end

  def self.down
    drop_table :vendors
  end
end
