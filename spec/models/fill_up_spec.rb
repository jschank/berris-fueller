require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FillUp do
  before(:each) do
    @valid_attributes = {
      :vehicle_id => "1",
      :date => Date.today,
      :odometer => "1",
      :cost_in_cents => "1",
      :gallons => "1.5",
      :brand => "value for brand",
      :grade => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    FillUp.create!(@valid_attributes)
  end
end
