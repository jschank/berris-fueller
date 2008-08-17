class FillUp < ActiveRecord::Base
  belongs_to :vehicle
  before_save :calc_elapsed_miles
  
  def miles_per_gallon
    elapsed_miles.to_f / gallons.to_f
  end
  
  def cost_per_mile
    cost / elapsed_miles.to_f
  end
  
  def cost_per_gallon
    cost / gallons.to_f
  end

  def self.previous_fill_up(vehicle, odometer)
    FillUp.find(
      :first, 
      :order => "odometer DESC", 
      :limit => 1, 
      :conditions => ["vehicle_id = :vehicle AND odometer < :odometer", {:vehicle => vehicle.id, :odometer => odometer }])
  end
  
  def self.next_fill_up(vehicle, odometer)
    FillUp.find(
      :first, 
      :order => "odometer ASC", 
      :limit => 1, 
      :conditions => ["vehicle_id = :vehicle AND odometer > :odometer", {:vehicle => vehicle.id, :odometer => odometer }])
  end
  
  private
  
  def calc_elapsed_miles
    if (self.vehicle.nil?)
      self.elapsed_miles = nil
    else
      fill_up = FillUp.previous_fill_up(vehicle, odometer)
      self.elapsed_miles = self.odometer - ( fill_up ? fill_up.odometer : self.vehicle.miles)
    end
  end  
  
end
