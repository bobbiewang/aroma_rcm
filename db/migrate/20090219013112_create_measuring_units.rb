class CreateMeasuringUnits < ActiveRecord::Migration
  def self.up
    create_table :measuring_units do |t|
      t.string :full_name
      t.string :abbr_name
      t.integer :precision

      t.timestamps
    end

    MeasuringUnit.create(:full_name => 'unit',
                         :abbr_name => 'u',
                         :precision => 0)
    MeasuringUnit.create(:full_name => 'milliliter',
                         :abbr_name => 'ml',
                         :precision => 0)
    MeasuringUnit.create(:full_name => 'drop',
                         :abbr_name => 'dp',
                         :precision => 0)
  end

  def self.down
    drop_table :measuring_units
  end
end
