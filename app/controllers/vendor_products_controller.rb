class VendorProductsController < ApplicationController
  # GET /vendor_products
  # GET /vendor_products.xml
  def index
    @vendors = Vendor.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vendor_products }
    end
  end

  # GET /vendor_products/1
  # GET /vendor_products/1.xml
  def show
    @vendor_product = VendorProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vendor_product }
    end
  end

  # GET /vendor_products/new
  # GET /vendor_products/new.xml
  def new
    @vendor_product = VendorProduct.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vendor_product }
    end
  end

  # GET /vendor_products/1/edit
  def edit
    @vendor_product = VendorProduct.find(params[:id])
  end

  # POST /vendor_products
  # POST /vendor_products.xml
  def create
    @vendor_product = VendorProduct.new(params[:vendor_product])

    respond_to do |format|
      if @vendor_product.save
        flash[:notice] = 'VendorProduct was successfully created.'
        format.html { redirect_to(@vendor_product) }
        format.xml  { render :xml => @vendor_product, :status => :created, :location => @vendor_product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vendor_product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vendor_products/1
  # PUT /vendor_products/1.xml
  def update
    @vendor_product = VendorProduct.find(params[:id])

    respond_to do |format|
      if @vendor_product.update_attributes(params[:vendor_product])
        flash[:notice] = 'VendorProduct was successfully updated.'
        format.html { redirect_to(@vendor_product) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vendor_product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_products/1
  # DELETE /vendor_products/1.xml
  def destroy
    @vendor_product = VendorProduct.find(params[:id])
    @vendor_product.destroy

    respond_to do |format|
      format.html { redirect_to(vendor_products_url) }
      format.xml  { head :ok }
    end
  end
end
