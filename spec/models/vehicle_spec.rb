require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vehicle do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :make => "value for make",
      :model => "value for model",
      :year => 2008,
      :miles => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    Vehicle.create!(@valid_attributes)
  end
end

describe Vehicle, "with fixtures loaded" do
  fixtures :vehicles, :fill_ups
  
  before(:each) do
    # fixtures are setup before this
  end  
  
  describe "Performing Updates" do
    before(:each) do
      @vehicle = Vehicle.find(vehicles(:new_car).id)
    end

    it "should should find an existing vehicle" do
      @vehicle.should eql(vehicles(:new_car))
    end

    it "should should have fillups" do
      @vehicle.should have(3).fill_ups
    end
    
    it "should modify the elapsed miles of the first fill up when changing the original miles on the vehicle" do
      @vehicle.update_attributes!( {:miles => 0}).should be_true
      @vehicle.errors.should be_empty
      @vehicle.miles.should eql(0)
      first_fill_up = @vehicle.fill_ups.sort{ |a,b| a.odometer <=> b.odometer}[0]
      first_fill_up.should eql(fill_ups(:one))
      first_fill_up.odometer.should eql(150)
      first_fill_up.elapsed_miles.should eql(150)
    end
  end  
end