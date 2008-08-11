require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/vehicles/show.html.erb" do
  include VehiclesHelper
  
  before(:each) do
    assigns[:vehicle] = @vehicle = stub_model(Vehicle,
      :name => "value for name",
      :make => "value for make",
      :model => "value for model",
      :miles => "1"
    )
  end

  it "should render attributes in <p>" do
    render "/vehicles/show.html.erb"
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ make/)
    response.should have_text(/value\ for\ model/)
    response.should have_text(/1/)
  end
end

