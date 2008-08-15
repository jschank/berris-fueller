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
  
  private
  
  def calc_elapsed_miles
    if (self.vehicle.nil?)
      self.elapsed_miles = nil
    else    
      fillup = FillUp.find(:first, :order => "odometer DESC", :conditions => {:vehicle_id => self.vehicle.id}  )
      self.elapsed_miles = self.odometer - ( fillup ? fillup.odometer : self.vehicle.miles)
    end
  end
end
