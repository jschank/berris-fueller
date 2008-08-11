require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/fill_ups/index.html.erb" do
  include FillUpsHelper
  
  before(:each) do
    assigns[:fill_ups] = [
      stub_model(FillUp,
        :brand => "value for brand",
        :grade => "1",
        :odometer => "1",
        :cost_in_cents => "1",
        :gallons => "1.5"
      ),
      stub_model(FillUp,
        :brand => "value for brand",
        :grade => "1",
        :odometer => "1",
        :cost_in_cents => "1",
        :gallons => "1.5"
      )
    ]
  end

  it "should render list of fill_ups" do
    render "/fill_ups/index.html.erb"
    response.should have_tag("tr>td", "value for brand", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "1.5", 2)
  end
end

