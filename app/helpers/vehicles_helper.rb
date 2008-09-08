module VehiclesHelper
  
  def grade_description(grade)
    case grade
    when 87 then "Regular"
    when 89 then "Plus"
    when 91 then "Premium"
    when 93 then "Ultra"
    end
  end
    
end
