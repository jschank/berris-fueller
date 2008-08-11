class Vehicle < ActiveRecord::Base
  has_many :fill_ups
  
  def to_param
    "#{id}-#{name.gsub(/\W/, '-').downcase}"
  end
end
