class AddElapsedMilesToFillUps < ActiveRecord::Migration
  def self.up
    add_column :fill_ups, :elapsed_miles, :integer
  end

  def self.down
    remove_column :fill_ups, :elapsed_miles
  end
end
