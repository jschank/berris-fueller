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
    if params[:data] == ""
      flash[:error] = "Must select a file to upload. Click the choose button."
      respond_to do |format|
        format.html { redirect_to :back }
        format.xml  { head :bad_request }
      end
    else
    
    lines = params[:data].readlines.collect!{|line| line.chomp}
    fields = lines.shift.split(/,/).collect!{|c| c.downcase.to_sym}
    data = lines.collect!{|line| line.chomp.split(/,/)}
  
    @successes = 0
    @failures = {}
    data.each do |item|
      array = fields.zip(item).flatten
      hash = Hash[*array]
    
      fill_up = @vehicle.fill_ups.build hash
      if(fill_up.save)
        @successes += 1
      else
        @failures[hash[:date]] = []
        fill_up.errors.each_full { |msg| @failures[hash[:date]] << msg}
      end
    end
  
    flash[:notice] = "Successfully imported #{ActionView::Helpers::TextHelper.pluralize(@successes, 'fill up', 'fill ups') }" unless @successes == 0
    flash[:error] = "Failed to import #{ActionView::Helpers::TextHelper.pluralize(@failures.length, 'fill up', 'fill ups') }" unless @failures.length == 0

    respond_to do |format|
      format.html #upload.html.erb
      format.xml  { head :ok }
    end
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
