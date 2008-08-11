class CreateVehicles < ActiveRecord::Migration
  def self.up
    create_table :vehicles do |t|
      t.string :name, :limit => 64, :null => false 
      t.string :make, :limit => 32
      t.string :model, :limit => 32
      t.integer :year
      t.integer :miles, :null => false, :default => 0 

      t.timestamps
    end
  end

  def self.down
    drop_table :vehicles
  end
end
