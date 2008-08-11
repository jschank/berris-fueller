require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FillUpsController do

  def mock_fill_up(stubs={})
    @mock_fill_up ||= mock_model(FillUp, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all fill_ups as @fill_ups" do
      FillUp.should_receive(:find).with(:all).and_return([mock_fill_up])
      get :index
      assigns[:fill_ups].should == [mock_fill_up]
    end

    describe "with mime type of xml" do
  
      it "should render all fill_ups as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        FillUp.should_receive(:find).with(:all).and_return(fill_ups = mock("Array of FillUps"))
        fill_ups.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested fill_up as @fill_up" do
      FillUp.should_receive(:find).with("37").and_return(mock_fill_up)
      get :show, :id => "37"
      assigns[:fill_up].should equal(mock_fill_up)
    end
    
    describe "with mime type of xml" do

      it "should render the requested fill_up as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        FillUp.should_receive(:find).with("37").and_return(mock_fill_up)
        mock_fill_up.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new fill_up as @fill_up" do
      FillUp.should_receive(:new).and_return(mock_fill_up)
      get :new
      assigns[:fill_up].should equal(mock_fill_up)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested fill_up as @fill_up" do
      FillUp.should_receive(:find).with("37").and_return(mock_fill_up)
      get :edit, :id => "37"
      assigns[:fill_up].should equal(mock_fill_up)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created fill_up as @fill_up" do
        FillUp.should_receive(:new).with({'these' => 'params'}).and_return(mock_fill_up(:save => true))
        post :create, :fill_up => {:these => 'params'}
        assigns(:fill_up).should equal(mock_fill_up)
      end

      it "should redirect to the created fill_up" do
        FillUp.stub!(:new).and_return(mock_fill_up(:save => true))
        post :create, :fill_up => {}
        response.should redirect_to(fill_up_url(mock_fill_up))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved fill_up as @fill_up" do
        FillUp.stub!(:new).with({'these' => 'params'}).and_return(mock_fill_up(:save => false))
        post :create, :fill_up => {:these => 'params'}
        assigns(:fill_up).should equal(mock_fill_up)
      end

      it "should re-render the 'new' template" do
        FillUp.stub!(:new).and_return(mock_fill_up(:save => false))
        post :create, :fill_up => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested fill_up" do
        FillUp.should_receive(:find).with("37").and_return(mock_fill_up)
        mock_fill_up.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :fill_up => {:these => 'params'}
      end

      it "should expose the requested fill_up as @fill_up" do
        FillUp.stub!(:find).and_return(mock_fill_up(:update_attributes => true))
        put :update, :id => "1"
        assigns(:fill_up).should equal(mock_fill_up)
      end

      it "should redirect to the fill_up" do
        FillUp.stub!(:find).and_return(mock_fill_up(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(fill_up_url(mock_fill_up))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested fill_up" do
        FillUp.should_receive(:find).with("37").and_return(mock_fill_up)
        mock_fill_up.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :fill_up => {:these => 'params'}
      end

      it "should expose the fill_up as @fill_up" do
        FillUp.stub!(:find).and_return(mock_fill_up(:update_attributes => false))
        put :update, :id => "1"
        assigns(:fill_up).should equal(mock_fill_up)
      end

      it "should re-render the 'edit' template" do
        FillUp.stub!(:find).and_return(mock_fill_up(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested fill_up" do
      FillUp.should_receive(:find).with("37").and_return(mock_fill_up)
      mock_fill_up.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the fill_ups list" do
      FillUp.stub!(:find).and_return(mock_fill_up(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(fill_ups_url)
    end

  end

end
