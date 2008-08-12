class Vehicle < ActiveRecord::Base
  has_many :fill_ups
  
  def current_miles
    return fill_ups.maximum(:odometer) unless fill_ups.count == 0
    return miles
  end
  
  def to_param
    "#{id}-#{name.gsub(/\W/, '-').downcase}"
  end
end
