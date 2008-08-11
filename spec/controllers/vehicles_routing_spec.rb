require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VehiclesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "vehicles", :action => "index").should == "/vehicles"
    end
  
    it "should map #new" do
      route_for(:controller => "vehicles", :action => "new").should == "/vehicles/new"
    end
  
    it "should map #show" do
      route_for(:controller => "vehicles", :action => "show", :id => 1).should == "/vehicles/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "vehicles", :action => "edit", :id => 1).should == "/vehicles/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "vehicles", :action => "update", :id => 1).should == "/vehicles/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "vehicles", :action => "destroy", :id => 1).should == "/vehicles/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/vehicles").should == {:controller => "vehicles", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/vehicles/new").should == {:controller => "vehicles", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/vehicles").should == {:controller => "vehicles", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/vehicles/1").should == {:controller => "vehicles", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/vehicles/1/edit").should == {:controller => "vehicles", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/vehicles/1").should == {:controller => "vehicles", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/vehicles/1").should == {:controller => "vehicles", :action => "destroy", :id => "1"}
    end
  end
end
