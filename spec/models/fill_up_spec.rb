require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

DELTA = 0.005

describe FillUp do
  before(:each) do
    @valid_attributes = {
      :vehicle_id => "1",
      :date => Date.today,
      :odometer => "100",
      :cost_in_cents => "1600",
      :gallons => "4",
      :brand => "value for brand",
      :grade => "87",
      :elapsed_miles => "100"
    }
    @fillup = FillUp.new
  end

  it "should create a new instance given valid attributes" do
    FillUp.create!(@valid_attributes)
  end
  
  it "should calculate Miles Per Gallon" do
    @fillup.attributes = @valid_attributes
    @fillup.elapsed_miles.should be_close(@fillup.miles_per_gallon * @fillup.gallons, DELTA)
  end
  
  it "should calculate Cost Per Mile" do
    @fillup.attributes = @valid_attributes
    @fillup.cost.cents.should be_close(@fillup.cost_per_mile.cents * @fillup.elapsed_miles, 1.0)
  end
  
  it "should calculate Cost Per Gallon" do
    @fillup.attributes = @valid_attributes
    @fillup.cost.cents.should be_close(@fillup.cost_per_gallon * @fillup.gallons, 1.0)
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
  
  describe "Performing Updates" do
    before(:each) do
      @fill_up = FillUp.find(fill_ups(:two).id)
    end

    it "should should find an existing fill_up" do
      @fill_up.should eql(fill_ups(:two))
    end

    it "should have correct elapsed miles in Second fill up" do
      @fill_up.elapsed_miles.should eql(150)
    end
    
    # I think this doesn't work because it seems that a spec should test a model's behavior independent of other models.
    # SO where do I test the behavior added by the controller - where changes to one model affect another model.
    # it "should have no errors after update when not updating the odometer" do
    #   @fill_up.update_attributes!( {:brand => 'Chevron', :grade => 91}).should be_true
    #   @fill_up.errors.should be_empty
    #   @fill_up.brand.should eql('Chevron')
    #   @fill_up.elapsed_miles.should eql(150)
    #   @fill_up = FillUp.find(fill_ups(:two).id)
    #   @fill_up.brand.should eql('Chevron')
    #   @fill_up.grade.should eql(91)
    #   @fill_up.elapsed_miles.should eql(150)
    # end
    
  end
  
end