class FillUp < ActiveRecord::Base
  belongs_to :vehicle
  validates_presence_of :vehicle_id, :date, :odometer, :cost_in_cents, :gallons, :brand, :grade
  validates_numericality_of :odometer, :integer_only => true
  validates_numericality_of :cost_in_cents
  validates_numericality_of :gallons
  validates_inclusion_of :grade, :in => [81, 83, 87, 91]
  
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
