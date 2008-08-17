require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FillUp do
  before(:each) do
    @valid_attributes = {
      :vehicle_id => "1",
      :date => Date.today,
      :odometer => "100",
      :cost_in_cents => "1600",
      :gallons => "4",
      :brand => "value for brand",
      :grade => "81",
      :elapsed_miles => "100"
    }
  end

  it "should create a new instance given valid attributes" do
    FillUp.create!(@valid_attributes)
  end
end

describe FillUp, "with fixtures loaded" do
  fixtures :vehicles, :fill_ups
  
  before(:each) do
    # fixtures are setup before this
  end  
  
  it "should have a non-empty collection of vehicles" do
    Vehicle.find(:all).should_not be_empty
  end
  
  it "should have two records" do
    Vehicle.should have(2).record
  end
  
  it "should should find an existing vehicle" do
    vehicle = Vehicle.find(vehicles(:new_car).id)
    vehicle.should eql(vehicles(:new_car))
  end
  
  it "should should have fillups" do
    vehicle = Vehicle.find(vehicles(:new_car).id)
    vehicle.should have(3).fill_ups
  end
  
end