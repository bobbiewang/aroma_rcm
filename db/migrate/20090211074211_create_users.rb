class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :null => false
      t.string :hashed_password, :null => false
      t.string :salt, :null => false

      t.timestamps
    end

    User.create(:name => "admin",
                :hashed_password => User.encrypted_password('admin', 'NaCl'),
                :salt => 'NaCl')
  end

  def self.down
    drop_table :users
  end
end
