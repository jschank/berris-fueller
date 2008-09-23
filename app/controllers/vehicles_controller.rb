class VehiclesController < ApplicationController
  before_filter :login_required
  before_filter :find_vehicle, :except => [:index, :new, :create]
  active_scaffold
  
  # GET /vehicles
  # GET /vehicles.xml
  def index
    @vehicles = Vehicle.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vehicles }
    end
  end

  # GET /vehicles/1
  # GET /vehicles/1.xml
  def show
    @mpg_chart = open_flash_chart_object(640, 480, mpg_chart_path(@vehicle))
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vehicle }
    end
  end

  # GET /vehicles/new
  # GET /vehicles/new.xml
  def new
    @vehicle = Vehicle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vehicle }
    end
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles
  # POST /vehicles.xml
  def create
    @vehicle = Vehicle.new(params[:vehicle])

    respond_to do |format|
      if @vehicle.save
        flash[:success] = 'Vehicle was successfully created.'
        format.html { redirect_to(@vehicle) }
        format.xml  { render :xml => @vehicle, :status => :created, :location => @vehicle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vehicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vehicles/1
  # PUT /vehicles/1.xml
  def update
    respond_to do |format|
      if @vehicle.update_attributes(params[:vehicle])
        first_fill_up = @vehicle.fill_ups.sort{ |a,b| a.odometer <=> b.odometer}[0] unless @vehicle.fill_ups.size == 0
        first_fill_up.save unless first_fill_up.nil?
        flash[:success] = 'Vehicle was successfully updated.'
        format.html { redirect_to(@vehicle) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vehicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.xml
  def destroy
    @vehicle.destroy

    respond_to do |format|
      format.html { redirect_to(vehicles_url) }
      format.xml  { head :ok }
    end
  end
  
  private

  def find_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
  
end
