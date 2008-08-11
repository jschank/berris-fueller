require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/fill_ups/edit.html.erb" do
  include FillUpsHelper
  
  before(:each) do
    assigns[:fill_up] = @fill_up = stub_model(FillUp,
      :new_record? => false,
      :brand => "value for brand",
      :grade => "1",
      :odometer => "1",
      :cost_in_cents => "1",
      :gallons => "1.5"
    )
  end

  it "should render edit form" do
    render "/fill_ups/edit.html.erb"
    
    response.should have_tag("form[action=#{fill_up_path(@fill_up)}][method=post]") do
      with_tag('input#fill_up_brand[name=?]', "fill_up[brand]")
      with_tag('input#fill_up_grade[name=?]', "fill_up[grade]")
      with_tag('input#fill_up_odometer[name=?]', "fill_up[odometer]")
      with_tag('input#fill_up_cost_in_cents[name=?]', "fill_up[cost_in_cents]")
      with_tag('input#fill_up_gallons[name=?]', "fill_up[gallons]")
    end
  end
end


