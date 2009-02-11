class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :null => false
      t.string :hashed_password, :null => false
      t.string :salt, :null => false

      t.timestamps
    end

    User.create(:name => "admin",
                :hashed_password => "988bb1980cbf7a39f196463c2833351dbd66b96e",
                :salt => "-6124667180.567904954503507")
  end

  def self.down
    drop_table :users
  end
end
