require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/vehicles/new.html.erb" do
  include VehiclesHelper
  
  before(:each) do
    assigns[:vehicle] = stub_model(Vehicle,
      :new_record? => true,
      :name => "value for name",
      :make => "value for make",
      :model => "value for model",
      :miles => "1"
    )
  end

  it "should render new form" do
    render "/vehicles/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", vehicles_path) do
      with_tag("input#vehicle_name[name=?]", "vehicle[name]")
      with_tag("input#vehicle_make[name=?]", "vehicle[make]")
      with_tag("input#vehicle_model[name=?]", "vehicle[model]")
      with_tag("input#vehicle_miles[name=?]", "vehicle[miles]")
    end
  end
end


