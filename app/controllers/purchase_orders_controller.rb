class PurchaseOrdersController < ApplicationController
  # GET /purchase_orders
  # GET /purchase_orders.xml
  def index
    @purchase_orders = PurchaseOrder.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @purchase_orders }
    end
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.xml
  def show
    @purchase_order = PurchaseOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchase_order }
    end
  end

  # GET /purchase_orders/new
  # GET /purchase_orders/new.xml
  def new
    if request.post?
      @vendor = Vendor.find(params[:vendor_id])
      @vendor_products = @vendor.vendor_products

      @purchase_order = PurchaseOrder.new(:vendor_id => @vendor.id)
      vendor_product_ids = params[:vendor_products] || { }
      vendor_product_ids.each_key do |id|
        vendor_product = VendorProduct.find(id)
        @purchase_order.purchase_order_items <<
          PurchaseOrderItem.new(:vendor_product_id => id,
                                :unit_price => vendor_product.price,
                                :quantity => 1)
      end

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @purchase_order }
      end
    else
      respond_to do |format|
        flash[:notice] = 'Please select some products to create a purchase order.'
        format.html { redirect_to :controller => :store, :action => :purchase }
      end
    end
  end

  # GET /purchase_orders/1/edit
  def edit
    @purchase_order = PurchaseOrder.find(params[:id])
    @vendor = @purchase_order.vendor
    @vendor_products = @vendor.vendor_products
  end

  # POST /purchase_orders
  # POST /purchase_orders.xml
  def create
    @purchase_order = PurchaseOrder.new(params[:purchase_order])

    respond_to do |format|
      if @purchase_order.save
        flash[:notice] = 'The purchase order was successfully created.'
        format.html { redirect_to(@purchase_order) }
        format.xml  { render :xml => @purchase_order, :status => :created, :location => @purchase_order }
      else
        flash[:notice] = "Failed to generate the purchase order: #{@purchase_order.errors.full_messages.uniq.join(';')}."
        format.html { redirect_to :controller => "store", :action => "purchase" }
        format.xml  { render :xml => @purchase_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /purchase_orders/1
  # PUT /purchase_orders/1.xml
  def update
    @purchase_order = PurchaseOrder.find(params[:id])

    respond_to do |format|
      if @purchase_order.update_attributes(params[:purchase_order])
        flash[:notice] = 'PurchaseOrder was successfully updated.'
        format.html { redirect_to(@purchase_order) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchase_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.xml
  def destroy
    @purchase_order = PurchaseOrder.find(params[:id])
    @purchase_order.destroy

    respond_to do |format|
      format.html { redirect_to(purchase_orders_url) }
      format.xml  { head :ok }
    end
  end
end
