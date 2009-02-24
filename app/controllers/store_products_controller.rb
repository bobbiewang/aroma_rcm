class StoreProductsController < ApplicationController
  # GET /store_products
  # GET /store_products.xml
  def index
    @store_products = StoreProduct.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @store_products }
    end
  end

  # GET /store_products/1
  # GET /store_products/1.xml
  def show
    @store_product = StoreProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @store_product }
    end
  end

  # GET /store_products/new
  # GET /store_products/new.xml
  def new
    @store_product = StoreProduct.new
    @measuring_units = MeasuringUnit.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @store_product }
    end
  end

  # GET /store_products/1/edit
  def edit
    @store_product = StoreProduct.find(params[:id])
    @measuring_units = MeasuringUnit.find(:all)
  end

  # POST /store_products
  # POST /store_products.xml
  def create
    @store_product = StoreProduct.new(params[:store_product])

    respond_to do |format|
      if @store_product.save
        flash[:notice] = 'StoreProduct was successfully created.'
        format.html { redirect_to(@store_product) }
        format.xml  { render :xml => @store_product, :status => :created, :location => @store_product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @store_product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /store_products/1
  # PUT /store_products/1.xml
  def update
    @store_product = StoreProduct.find(params[:id])

    respond_to do |format|
      if @store_product.update_attributes(params[:store_product])
        flash[:notice] = 'StoreProduct was successfully updated.'
        format.html { redirect_to(@store_product) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store_product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /store_products/1
  # DELETE /store_products/1.xml
  def destroy
    @store_product = StoreProduct.find(params[:id])
    @store_product.destroy

    respond_to do |format|
      format.html { redirect_to(store_products_url) }
      format.xml  { head :ok }
    end
  end
end
