require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/vehicles/index.html.erb" do
  include VehiclesHelper
  
  before(:each) do
    assigns[:vehicles] = [
      stub_model(Vehicle,
        :name => "value for name",
        :make => "value for make",
        :model => "value for model",
        :miles => "1"
      ),
      stub_model(Vehicle,
        :name => "value for name",
        :make => "value for make",
        :model => "value for model",
        :miles => "1"
      )
    ]
  end

  it "should render list of vehicles" do
    render "/vehicles/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for make", 2)
    response.should have_tag("tr>td", "value for model", 2)
    response.should have_tag("tr>td", "1", 2)
  end
end

