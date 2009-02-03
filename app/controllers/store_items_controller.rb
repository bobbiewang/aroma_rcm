class StoreItemsController < ApplicationController
  # GET /store_items
  # GET /store_items.xml
  def index
    @store_items = StoreItem.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @store_items }
    end
  end

  # GET /store_items/1
  # GET /store_items/1.xml
  def show
    @store_item = StoreItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @store_item }
    end
  end

  # GET /store_items/new
  # GET /store_items/new.xml
  def new
    @store_item = StoreItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @store_item }
    end
  end

  # GET /store_items/1/edit
  def edit
    @store_item = StoreItem.find(params[:id])
  end

  # POST /store_items
  # POST /store_items.xml
  def create
    @store_item = StoreItem.new(params[:store_item])

    respond_to do |format|
      if @store_item.save
        flash[:notice] = 'StoreItem was successfully created.'
        format.html { redirect_to(@store_item) }
        format.xml  { render :xml => @store_item, :status => :created, :location => @store_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @store_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /store_items/1
  # PUT /store_items/1.xml
  def update
    @store_item = StoreItem.find(params[:id])

    respond_to do |format|
      if @store_item.update_attributes(params[:store_item])
        flash[:notice] = 'StoreItem was successfully updated.'
        format.html { redirect_to(@store_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /store_items/1
  # DELETE /store_items/1.xml
  def destroy
    @store_item = StoreItem.find(params[:id])
    @store_item.destroy

    respond_to do |format|
      format.html { redirect_to(store_items_url) }
      format.xml  { head :ok }
    end
  end
end
