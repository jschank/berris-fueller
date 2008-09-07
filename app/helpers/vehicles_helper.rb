module VehiclesHelper
  
  def sorted_fill_ups(vehicle)
    fill_ups = vehicle.fill_ups.sort { |a,b| a.odometer <=> b.odometer}
    render :partial => 'vehicle_fill_up', :locals => {:fill_ups => fill_ups, :vehicle => vehicle  }
  end
  
  def grade_description(grade)
    case grade
    when 87 then "Regular"
    when 89 then "Plus"
    when 91 then "Premium"
    when 93 then "Ultra"
    end
  end
    
end
