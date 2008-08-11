require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vehicle do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :make => "value for make",
      :model => "value for model",
      :year => Date.today,
      :miles => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    Vehicle.create!(@valid_attributes)
  end
end
