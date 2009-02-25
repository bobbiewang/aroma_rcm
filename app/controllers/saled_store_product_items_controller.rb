class SaledStoreProductItemsController < ApplicationController
  # GET /saled_store_product_items
  # GET /saled_store_product_items.xml
  def index
    @saled_store_product_items = SaledStoreProductItem.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @saled_store_product_items }
    end
  end

  # GET /saled_store_product_items/1
  # GET /saled_store_product_items/1.xml
  def show
    @saled_store_product_item = SaledStoreProductItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @saled_store_product_item }
    end
  end

  # GET /saled_store_product_items/new
  # GET /saled_store_product_items/new.xml
  def new
    @saled_store_product_item = SaledStoreProductItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @saled_store_product_item }
    end
  end

  # GET /saled_store_product_items/1/edit
  def edit
    @saled_store_product_item = SaledStoreProductItem.find(params[:id])
  end

  # POST /saled_store_product_items
  # POST /saled_store_product_items.xml
  def create
    @saled_store_product_item = SaledStoreProductItem.new(params[:saled_store_product_item])

    respond_to do |format|
      if @saled_store_product_item.save
        flash[:notice] = 'SaledStoreProductItem was successfully created.'
        format.html { redirect_to(@saled_store_product_item) }
        format.xml  { render :xml => @saled_store_product_item, :status => :created, :location => @saled_store_product_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @saled_store_product_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /saled_store_product_items/1
  # PUT /saled_store_product_items/1.xml
  def update
    @saled_store_product_item = SaledStoreProductItem.find(params[:id])

    respond_to do |format|
      if @saled_store_product_item.update_attributes(params[:saled_store_product_item])
        flash[:notice] = 'SaledStoreProductItem was successfully updated.'
        format.html { redirect_to(@saled_store_product_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @saled_store_product_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /saled_store_product_items/1
  # DELETE /saled_store_product_items/1.xml
  def destroy
    @saled_store_product_item = SaledStoreProductItem.find(params[:id])
    @saled_store_product_item.destroy

    respond_to do |format|
      format.html { redirect_to(saled_store_product_items_url) }
      format.xml  { head :ok }
    end
  end
end
