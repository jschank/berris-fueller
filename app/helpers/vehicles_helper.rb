module VehiclesHelper
  
  def sorted_fill_ups(vehicle)
    fill_ups = vehicle.fill_ups.sort { |a,b| a.odometer <=> b.odometer}
    render :partial => 'vehicle_fill_up', :locals => {:fill_ups => fill_ups, :vehicle => vehicle  }
  end
    
end
