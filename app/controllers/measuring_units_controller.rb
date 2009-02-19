class MeasuringUnitsController < ApplicationController
  # GET /measuring_units
  # GET /measuring_units.xml
  def index
    @measuring_units = MeasuringUnit.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @measuring_units }
    end
  end

  # GET /measuring_units/1
  # GET /measuring_units/1.xml
  def show
    @measuring_unit = MeasuringUnit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @measuring_unit }
    end
  end

  # GET /measuring_units/new
  # GET /measuring_units/new.xml
  def new
    @measuring_unit = MeasuringUnit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @measuring_unit }
    end
  end

  # GET /measuring_units/1/edit
  def edit
    @measuring_unit = MeasuringUnit.find(params[:id])
  end

  # POST /measuring_units
  # POST /measuring_units.xml
  def create
    @measuring_unit = MeasuringUnit.new(params[:measuring_unit])

    respond_to do |format|
      if @measuring_unit.save
        flash[:notice] = 'MeasuringUnit was successfully created.'
        format.html { redirect_to(@measuring_unit) }
        format.xml  { render :xml => @measuring_unit, :status => :created, :location => @measuring_unit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @measuring_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /measuring_units/1
  # PUT /measuring_units/1.xml
  def update
    @measuring_unit = MeasuringUnit.find(params[:id])

    respond_to do |format|
      if @measuring_unit.update_attributes(params[:measuring_unit])
        flash[:notice] = 'MeasuringUnit was successfully updated.'
        format.html { redirect_to(@measuring_unit) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @measuring_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /measuring_units/1
  # DELETE /measuring_units/1.xml
  def destroy
    @measuring_unit = MeasuringUnit.find(params[:id])
    @measuring_unit.destroy

    respond_to do |format|
      format.html { redirect_to(measuring_units_url) }
      format.xml  { head :ok }
    end
  end
end
