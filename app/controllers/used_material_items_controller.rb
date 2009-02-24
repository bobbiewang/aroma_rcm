class UsedMaterialItemsController < ApplicationController
  # GET /used_material_items
  # GET /used_material_items.xml
  def index
    @used_material_items = UsedMaterialItem.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @used_material_items }
    end
  end

  # GET /used_material_items/1
  # GET /used_material_items/1.xml
  def show
    @used_material_item = UsedMaterialItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @used_material_item }
    end
  end

  # GET /used_material_items/new
  # GET /used_material_items/new.xml
  def new
    @used_material_item = UsedMaterialItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @used_material_item }
    end
  end

  # GET /used_material_items/1/edit
  def edit
    @used_material_item = UsedMaterialItem.find(params[:id])
  end

  # POST /used_material_items
  # POST /used_material_items.xml
  def create
    @used_material_item = UsedMaterialItem.new(params[:used_material_item])

    respond_to do |format|
      if @used_material_item.save
        flash[:notice] = 'UsedMaterialItem was successfully created.'
        format.html { redirect_to(@used_material_item) }
        format.xml  { render :xml => @used_material_item, :status => :created, :location => @used_material_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @used_material_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /used_material_items/1
  # PUT /used_material_items/1.xml
  def update
    @used_material_item = UsedMaterialItem.find(params[:id])

    respond_to do |format|
      if @used_material_item.update_attributes(params[:used_material_item])
        flash[:notice] = 'UsedMaterialItem was successfully updated.'
        format.html { redirect_to(@used_material_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @used_material_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /used_material_items/1
  # DELETE /used_material_items/1.xml
  def destroy
    @used_material_item = UsedMaterialItem.find(params[:id])
    @used_material_item.destroy

    respond_to do |format|
      format.html { redirect_to(used_material_items_url) }
      format.xml  { head :ok }
    end
  end
end
