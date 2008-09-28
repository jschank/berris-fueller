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
  
  def total_gallons
    fill_ups.inject(0) { |sum, fillup| sum + fillup.gallons}
  end
  
  def total_fuel_cost
    total_cents = fill_ups.inject(0) { |sum, fillup| sum + fillup.cost.cents }
    Money.create_from_cents(total_cents)
  end
  
  def overall_miles_per_gallon
    current_miles / total_gallons
  end
  
  def savings_vs_hypothetical_mpg(mpg)
    total_cents = fill_ups.inject(0) do |sum, fillup|
      gallons = fillup.elapsed_miles / mpg
      cost_cents = gallons * (fillup.cost_per_gallon.cents)
      savings = cost_cents - fillup.cost.cents
      sum + savings
    end
    Money.create_from_cents(total_cents)
  end
  
  def to_param
    "#{id}-#{name.gsub(/\W/, '-').downcase}"
  end
  
  private
  
end
