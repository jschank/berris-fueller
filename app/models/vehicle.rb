class Vehicle < ActiveRecord::Base
  has_many :fill_ups, :order => 'odometer ASC'
  validates_presence_of :name, :make, :model, :year, :miles
  validates_length_of :year, :is => 4
  validates_numericality_of :year, :integer_only => true
  validates_numericality_of :miles, :integer_only => true
  validates_associated :fill_ups
  
  def current_miles
    return fill_ups[-1].odometer unless fill_ups.size == 0
    return miles
  end
  
  def to_param
    "#{id}-#{name.gsub(/\W/, '-').downcase}"
  end
  
  private
  
end
