class FillUpsController < ApplicationController
  def create
    @vehicle = Vehicle.find(params[:vehicle_id])
    @fillup = @vehicle.fill_ups.build params[:fillup]

    respond_to do |format|
      if @fillup.save
        flash[:notice] = 'Fill up was successfully created.'
        format.html { redirect_to(vehicles_path) }
        format.xml  { render :xml => @fillup, :status => :created, :location => @fillup }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fillup.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @fillup = FillUp.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fillup }
    end
  end

  def destroy
    @vehicle = Vehicle.find(params[:vehicle_id])
    @fillup = FillUp.find(params[:id])
    @fillup.destroy

    respond_to do |format|
      format.html { redirect_to(@vehicle) }
      format.xml  { head :ok }
    end
  end
  
end
