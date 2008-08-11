require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/fill_ups/show.html.erb" do
  include FillUpsHelper
  
  before(:each) do
    assigns[:fill_up] = @fill_up = stub_model(FillUp,
      :brand => "value for brand",
      :grade => "1",
      :odometer => "1",
      :cost_in_cents => "1",
      :gallons => "1.5"
    )
  end

  it "should render attributes in <p>" do
    render "/fill_ups/show.html.erb"
    response.should have_text(/value\ for\ brand/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1\.5/)
  end
end

