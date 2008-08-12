module VehiclesHelper
  def should_show_current_miles
    @vehicle.fill_ups.count > 0
  end
  
end
