require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VehiclesController do

  def mock_vehicle(stubs={})
    @mock_vehicle ||= mock_model(Vehicle, stubs)    
  end
  
  describe "responding to GET index" do

    it "should expose all vehicles as @vehicles" do
      Vehicle.should_receive(:find).with(:all).and_return([mock_vehicle])
      get :index
      assigns[:vehicles].should == [mock_vehicle]
    end

    describe "with mime type of xml" do
  
      it "should render all vehicles as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Vehicle.should_receive(:find).with(:all).and_return(vehicles = mock("Array of Vehicles"))
        vehicles.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested vehicle as @vehicle" do
      Vehicle.should_receive(:find).with("37").and_return(mock_vehicle)
      get :show, :id => "37"
      assigns[:vehicle].should equal(mock_vehicle)
    end

    describe "with mime type of xml" do

      it "should render the requested vehicle as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Vehicle.should_receive(:find).with("37").and_return(mock_vehicle)
        mock_vehicle.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new vehicle as @vehicle" do
      Vehicle.should_receive(:new).and_return(mock_vehicle)
      get :new
      assigns[:vehicle].should equal(mock_vehicle)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested vehicle as @vehicle" do
      Vehicle.should_receive(:find).with("37").and_return(mock_vehicle)
      get :edit, :id => "37"
      assigns[:vehicle].should equal(mock_vehicle)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created vehicle as @vehicle" do
        Vehicle.should_receive(:new).with({'these' => 'params'}).and_return(mock_vehicle(:save => true))
        post :create, :vehicle => {:these => 'params'}
        assigns(:vehicle).should equal(mock_vehicle)
      end

      it "should redirect to the created vehicle" do
        Vehicle.stub!(:new).and_return(mock_vehicle(:save => true))
        post :create, :vehicle => {}
        response.should redirect_to(vehicle_url(mock_vehicle))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved vehicle as @vehicle" do
        Vehicle.stub!(:new).with({'these' => 'params'}).and_return(mock_vehicle(:save => false))
        post :create, :vehicle => {:these => 'params'}
        assigns(:vehicle).should equal(mock_vehicle)
      end

      it "should re-render the 'new' template" do
        Vehicle.stub!(:new).and_return(mock_vehicle(:save => false))
        post :create, :vehicle => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested vehicle" do
        Vehicle.should_receive(:find).with("37").and_return(mock_vehicle)
        mock_vehicle.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :vehicle => {:these => 'params'}
      end

      it "should expose the requested vehicle as @vehicle" do
        Vehicle.stub!(:find).and_return(mock_vehicle(:update_attributes => true))
        put :update, :id => "1"
        assigns(:vehicle).should equal(mock_vehicle)
      end

      it "should redirect to the vehicle" do
        Vehicle.stub!(:find).and_return(mock_vehicle(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(vehicle_url(mock_vehicle))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested vehicle" do
        Vehicle.should_receive(:find).with("37").and_return(mock_vehicle)
        mock_vehicle.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :vehicle => {:these => 'params'}
      end

      it "should expose the vehicle as @vehicle" do
        Vehicle.stub!(:find).and_return(mock_vehicle(:update_attributes => false))
        put :update, :id => "1"
        assigns(:vehicle).should equal(mock_vehicle)
      end

      it "should re-render the 'edit' template" do
        Vehicle.stub!(:find).and_return(mock_vehicle(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested vehicle" do
      Vehicle.should_receive(:find).with("37").and_return(mock_vehicle)
      mock_vehicle.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the vehicles list" do
      Vehicle.stub!(:find).and_return(mock_vehicle(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(vehicles_url)
    end

  end

end
