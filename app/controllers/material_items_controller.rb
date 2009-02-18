class MaterialItemsController < ApplicationController
  # GET /material_items
  # GET /material_items.xml
  def index
    @material_items = MaterialItems.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @material_items }
    end
  end

  # GET /material_items/1
  # GET /material_items/1.xml
  def show
    @material_items = MaterialItems.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @material_items }
    end
  end

  # GET /material_items/new
  # GET /material_items/new.xml
  def new
    @material_items = MaterialItems.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @material_items }
    end
  end

  # GET /material_items/1/edit
  def edit
    @material_items = MaterialItems.find(params[:id])
  end

  # POST /material_items
  # POST /material_items.xml
  def create
    @material_items = MaterialItems.new(params[:material_items])

    respond_to do |format|
      if @material_items.save
        flash[:notice] = 'MaterialItems was successfully created.'
        format.html { redirect_to(@material_items) }
        format.xml  { render :xml => @material_items, :status => :created, :location => @material_items }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @material_items.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /material_items/1
  # PUT /material_items/1.xml
  def update
    @material_items = MaterialItems.find(params[:id])

    respond_to do |format|
      if @material_items.update_attributes(params[:material_items])
        flash[:notice] = 'MaterialItems was successfully updated.'
        format.html { redirect_to(@material_items) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @material_items.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /material_items/1
  # DELETE /material_items/1.xml
  def destroy
    @material_items = MaterialItems.find(params[:id])
    @material_items.destroy

    respond_to do |format|
      format.html { redirect_to(material_items_url) }
      format.xml  { head :ok }
    end
  end
end
