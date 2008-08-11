class FillUpsController < ApplicationController
  # GET /fill_ups
  # GET /fill_ups.xml
  def index
    @fill_ups = FillUp.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fill_ups }
    end
  end

  # GET /fill_ups/1
  # GET /fill_ups/1.xml
  def show
    @fill_up = FillUp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fill_up }
    end
  end

  # GET /fill_ups/new
  # GET /fill_ups/new.xml
  def new
    @fill_up = FillUp.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fill_up }
    end
  end

  # GET /fill_ups/1/edit
  def edit
    @fill_up = FillUp.find(params[:id])
  end

  # POST /fill_ups
  # POST /fill_ups.xml
  def create
    @fill_up = FillUp.new(params[:fill_up])

    respond_to do |format|
      if @fill_up.save
        flash[:notice] = 'FillUp was successfully created.'
        format.html { redirect_to(@fill_up) }
        format.xml  { render :xml => @fill_up, :status => :created, :location => @fill_up }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fill_up.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fill_ups/1
  # PUT /fill_ups/1.xml
  def update
    @fill_up = FillUp.find(params[:id])

    respond_to do |format|
      if @fill_up.update_attributes(params[:fill_up])
        flash[:notice] = 'FillUp was successfully updated.'
        format.html { redirect_to(@fill_up) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fill_up.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fill_ups/1
  # DELETE /fill_ups/1.xml
  def destroy
    @fill_up = FillUp.find(params[:id])
    @fill_up.destroy

    respond_to do |format|
      format.html { redirect_to(fill_ups_url) }
      format.xml  { head :ok }
    end
  end
end
