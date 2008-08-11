class CreateFillUps < ActiveRecord::Migration
  def self.up
    create_table :fill_ups do |t|
      t.integer :vehicle_id
      t.date :date, :null => false 
      t.integer :odometer, :null => false, :default => 0
      t.integer :cost_in_cents, :null => false 
      t.float :gallons, :null => false
      t.string :brand
      t.integer :grade

      t.timestamps
    end
  end

  def self.down
    drop_table :fill_ups
  end
end
