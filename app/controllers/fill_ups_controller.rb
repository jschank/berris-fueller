class FillUpsController < ApplicationController
  def create
    @vehicle = Vehicle.find params[:vehicle_id]
    @fill_up = @vehicle.fill_ups.build params[:fill_up]

    respond_to do |format|
      if @fill_up.save
        flash[:notice] = 'Fill up was successfully created.'
        format.html { redirect_to(vehicles_path) }
        format.xml  { render :xml => @fill_up, :status => :created, :location => @fill_up }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fill_up.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @fill_up = FillUp.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fill_up }
    end
  end

  def edit
    @vehicle = Vehicle.find params[:vehicle_id]
    @fill_up = FillUp.find(params[:id])
  end

  def update
    @vehicle = Vehicle.find params[:vehicle_id]
    @fill_up = FillUp.find(params[:id])

    respond_to do |format|
      if @fill_up.update_attributes(params[:fill_up])
        flash[:notice] = 'Fill up was successfully updated.'
        format.html { redirect_to(@vehicle) }
        format.xml  { head :ok }
      else
        format.html { redirect_to edit_vehicle_fill_up(@fill_up.vehicle_id, @fill_up) }
        format.xml  { render :xml => @fill_up.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @vehicle = Vehicle.find(params[:vehicle_id])
    @fill_up = FillUp.find(params[:id])
    @fill_up.destroy

    respond_to do |format|
      format.html { redirect_to(@vehicle) }
      format.xml  { head :ok }
    end
  end
  
end
