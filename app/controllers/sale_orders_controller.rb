class SaleOrdersController < ApplicationController
  # GET /sale_orders
  # GET /sale_orders.xml
  def index
    @sale_orders = SaleOrder.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sale_orders }
    end
  end

  # GET /sale_orders/1
  # GET /sale_orders/1.xml
  def show
    @sale_order = SaleOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sale_order }
    end
  end

  # GET /sale_orders/new
  # GET /sale_orders/new.xml
  def new
    if request.post?
      @customers = Customer.find(:all).sort
      @vendor_product_items = PurchaseOrderItem.avail_items
      @store_product_items = StoreProductItem.avail_items

      @sale_order = SaleOrder.new
      purchase_order_items = params[:purchase_order_items] || { }
      purchase_order_items.each_key do |id|
        poi = PurchaseOrderItem.find(id)
        @sale_order.sale_order_items <<
          SaleOrderItem.new(:purchase_order_item_id => poi.id,
                            :quantity => 1)
      end

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @sale_order }
      end
    else
      respond_to do |format|
        flash[:notice] = 'Please select some products to create a sale order.'
        format.html { redirect_to :controller => :store, :action => :sale }
      end
    end
  end

  # GET /sale_orders/1/edit
  def edit
    @customers = Customer.find(:all).sort
    @sale_order = SaleOrder.find(params[:id])

    saled_vendor_product_items = @sale_order.sale_order_items.map { |i| i.purchase_order_item }
    @vendor_product_items = PurchaseOrderItem.avail_items | saled_vendor_product_items

    saled_store_product_items = @sale_order.saled_store_product_items.map { |i| i.store_product_item }
    @store_product_items = StoreProductItem.avail_items | saled_store_product_items
  end

  # POST /sale_orders
  # POST /sale_orders.xml
  def create
    @sale_order = SaleOrder.new(params[:sale_order])
    @customers = Customer.find(:all).sort

    respond_to do |format|
      if @sale_order.save!
        flash[:notice] = 'Sale Order was successfully created.'
        format.html { redirect_to(@sale_order) }
        format.xml  { render :xml => @sale_order, :status => :created, :location => @sale_order }
      else
        flash[:notice] = 'Failed to create the Sale Order.'
        format.html { redirect_to :controller => 'store', :action => 'sale' }
        format.xml  { render :xml => @sale_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sale_orders/1
  # PUT /sale_orders/1.xml
  def update
    @sale_order = SaleOrder.find(params[:id])

    respond_to do |format|
      if @sale_order.update_attributes(params[:sale_order])
        flash[:notice] = 'SaleOrder was successfully updated.'
        format.html { redirect_to(@sale_order) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sale_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_orders/1
  # DELETE /sale_orders/1.xml
  def destroy
    @sale_order = SaleOrder.find(params[:id])
    @sale_order.destroy

    respond_to do |format|
      format.html { redirect_to(sale_orders_url) }
      format.xml  { head :ok }
    end
  end
end
