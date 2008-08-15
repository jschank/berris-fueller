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
