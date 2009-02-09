class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :name
      t.string :gender
      t.string :address
      t.string :post_code
      t.string :telephone
      t.string :mobilephone
      t.date :birthday
      t.text :details

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
