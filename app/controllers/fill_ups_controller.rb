#require 'ar-extensions'
class FillUpsController < ApplicationController
  before_filter :find_vehicle
  before_filter :find_fill_up, :except => [:index, :new, :create, :import, :upload]
  
  def create
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
  end

  def update
    old_reading = @fill_up.odometer
    respond_to do |format|
      if @fill_up.update_attributes(params[:fill_up])
        next_fill_up = FillUp.next_fill_up(@vehicle, old_reading)
        next_fill_up.save unless next_fill_up.nil? || next_fill_up.id == @fill_up.id

        new_next_fill_up = FillUp.next_fill_up(@vehicle, @fill_up.odometer)
        new_next_fill_up.save unless new_next_fill_up.nil? || new_next_fill_up.id == @fill_up.id
        flash[:notice] = 'Fill up was successfully updated.'
        format.html { redirect_to(@vehicle) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Fill up update failed!'
        format.html { redirect_to edit_vehicle_fill_up(@fill_up.vehicle_id, @fill_up) }
        format.xml  { render :xml => @fill_up.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @fill_up.destroy
    next_fill_up = FillUp.next_fill_up(@vehicle, @fill_up.odometer)
    next_fill_up.save unless next_fill_up.nil?

    respond_to do |format|
      format.html { redirect_to(@vehicle) }
      format.xml  { head :ok }
    end
  end
  
  def import
  end
  
  def upload
    lines = params[:data].readlines.collect!{|line| line.chomp}
    fields = lines.shift.split(/,/).collect!{|c| c.downcase.to_sym}
    data = lines.collect!{|line| line.chomp.split(/,/)}
    
    # OK, it appears that import does not understand the association, so it doesn't add the vehicle id to each row.
    fields << :vehicle_id
    data.collect!{|line| line << @vehicle.id}    
    
    if @vehicle.fill_ups.import fields, data
      flash[:notice] = "Successfully imported #{ActionView::Helpers::TextHelper.pluralize(data.length, 'fill up', 'fill ups') }"
    else
      flash[:error] = "Failed to import fill ups"
    end
    respond_to do |format|
      format.html { redirect_to(@vehicle) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_vehicle
    @vehicle = Vehicle.find params[:vehicle_id]
  end
  
  def find_fill_up
    @fill_up = FillUp.find(params[:id])    
  end
  
end
