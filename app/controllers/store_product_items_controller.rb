class StoreProductItemsController < ApplicationController
  # GET /store_product_items
  # GET /store_product_items.xml
  def index
    @store_product_items = StoreProductItem.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @store_product_items }
    end
  end

  # GET /store_product_items/1
  # GET /store_product_items/1.xml
  def show
    @store_product_item = StoreProductItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @store_product_item }
    end
  end

  # GET /store_product_items/new
  # GET /store_product_items/new.xml
  def new
    @store_product_item = StoreProductItem.new(:quantity => 1)

    @store_products = StoreProduct.find(:all)
    @material_items = MaterialItem.find(:all, :conditions => ["usedup =? ", false])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @store_product_item }
    end
  end

  # GET /store_product_items/1/edit
  def edit
    @store_product_item = StoreProductItem.find(params[:id])

    @store_products = StoreProduct.find(:all)
    @material_items = MaterialItem.find(:all, :conditions => ["usedup =? ", false])
  end

  # POST /store_product_items
  # POST /store_product_items.xml
  def create
    @store_product_item = StoreProductItem.new(params[:store_product_item])

    respond_to do |format|
      if @store_product_item.save
        flash[:notice] = 'StoreProductItem was successfully created.'
        format.html { redirect_to(@store_product_item) }
        format.xml  { render :xml => @store_product_item, :status => :created, :location => @store_product_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @store_product_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /store_product_items/1
  # PUT /store_product_items/1.xml
  def update
    @store_product_item = StoreProductItem.find(params[:id])

    respond_to do |format|
      if @store_product_item.update_attributes(params[:store_product_item])
        flash[:notice] = 'StoreProductItem was successfully updated.'
        format.html { redirect_to(@store_product_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store_product_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /store_product_items/1
  # DELETE /store_product_items/1.xml
  def destroy
    @store_product_item = StoreProductItem.find(params[:id])
    @store_product_item.destroy

    respond_to do |format|
      format.html { redirect_to(store_product_items_url) }
      format.xml  { head :ok }
    end
  end
end
