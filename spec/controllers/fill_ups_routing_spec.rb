require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FillUpsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "fill_ups", :action => "index").should == "/fill_ups"
    end
  
    it "should map #new" do
      route_for(:controller => "fill_ups", :action => "new").should == "/fill_ups/new"
    end
  
    it "should map #show" do
      route_for(:controller => "fill_ups", :action => "show", :id => 1).should == "/fill_ups/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "fill_ups", :action => "edit", :id => 1).should == "/fill_ups/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "fill_ups", :action => "update", :id => 1).should == "/fill_ups/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "fill_ups", :action => "destroy", :id => 1).should == "/fill_ups/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/fill_ups").should == {:controller => "fill_ups", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/fill_ups/new").should == {:controller => "fill_ups", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/fill_ups").should == {:controller => "fill_ups", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/fill_ups/1").should == {:controller => "fill_ups", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/fill_ups/1/edit").should == {:controller => "fill_ups", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/fill_ups/1").should == {:controller => "fill_ups", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/fill_ups/1").should == {:controller => "fill_ups", :action => "destroy", :id => "1"}
    end
  end
end
