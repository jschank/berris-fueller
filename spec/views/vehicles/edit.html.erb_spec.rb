require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/vehicles/edit.html.erb" do
  include VehiclesHelper
  
  before(:each) do
    assigns[:vehicle] = @vehicle = stub_model(Vehicle,
      :new_record? => false,
      :name => "value for name",
      :make => "value for make",
      :model => "value for model",
      :miles => "1"
    )
  end

  it "should render edit form" do
    render "/vehicles/edit.html.erb"
    
    response.should have_tag("form[action=#{vehicle_path(@vehicle)}][method=post]") do
      with_tag('input#vehicle_name[name=?]', "vehicle[name]")
      with_tag('input#vehicle_make[name=?]', "vehicle[make]")
      with_tag('input#vehicle_model[name=?]', "vehicle[model]")
      with_tag('input#vehicle_miles[name=?]', "vehicle[miles]")
    end
  end
end


