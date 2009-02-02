class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string :full_name
      t.string :iso_code
      t.string :symbol

      t.timestamps
    end

    Currency.create(:full_name => "Chinese Yuan Renminbi",
                    :iso_code  => "CNY",
                    :symbol    => "￥")
    Currency.create(:full_name => "Pound Sterling",
                    :iso_code  => "GBP",
                    :symbol    => "£")
    Currency.create(:full_name => "Euro",
                    :iso_code  => "EUR",
                    :symbol    => "€")
    Currency.create(:full_name => "US Dollar",
                    :iso_code  => "USD",
                    :symbol    => "$")
  end

  def self.down
    drop_table :currencies
  end
end
