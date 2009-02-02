class CreateVendors < ActiveRecord::Migration
  def self.up
    create_table :vendors do |t|
      t.string :full_name
      t.string :abbr_name
      t.integer :currency_id

      t.timestamps
    end

    Vendor.create(:full_name => "香提",
                  :abbr_name => "XT",
                  :currency_id => 1)
    Vendor.create(:full_name => "Shirley Price",
                  :abbr_name => "SP",
                  :currency_id => 2)
    Vendor.create(:full_name => "Penny Price",
                  :abbr_name => "PP",
                  :currency_id => 2)
  end

  def self.down
    drop_table :vendors
  end
end
