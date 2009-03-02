class MaterialItemsController < ApplicationController
  # GET /material_items
  # GET /material_items.xml
  def index
    @material_items = MaterialItem.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @material_items }
    end
  end

  # GET /material_item/1
  # GET /material_item/1.xml
  def show
    @material_item = MaterialItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @material_item }
    end
  end

  # GET /material_item/new
  # GET /material_item/new.xml
  def new
    @material_item = MaterialItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @material_item }
    end
  end

  # GET /material_item/1/edit
  def edit
    @material_item = MaterialItem.find(params[:id])
  end

  # POST /material_item
  # POST /material_item.xml
  def create
    @material_item = MaterialItem.new(params[:material_item])

    respond_to do |format|
      if @material_item.save
        flash[:notice] = 'MaterialItem was successfully created.'
        format.html { redirect_to(@material_item) }
        format.xml  { render :xml => @material_item, :status => :created, :location => @material_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @material_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /material_item/1
  # PUT /material_item/1.xml
  def update
    @material_item = MaterialItem.find(params[:id])

    respond_to do |format|
      if @material_item.update_attributes(params[:material_item])
        flash[:notice] = 'MaterialItem was successfully updated.'
        format.html { redirect_to(@material_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @material_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /material_item/1
  # DELETE /material_item/1.xml
  def destroy
    @material_item = MaterialItem.find(params[:id])

    unless @material_item.destroy
      flash[:notice] = @material_item.errors.full_messages
    end

    respond_to do |format|
      format.html { redirect_to(material_items_url) }
      format.xml  { head :ok }
    end
  end
end
