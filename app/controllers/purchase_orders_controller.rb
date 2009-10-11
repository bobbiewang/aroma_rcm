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
    @purchase_order_items = @purchase_order.purchase_order_items
    @purchase_order_items.sort! { |x,y| x.vendor_product.title <=> y.vendor_product.title }

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchase_order }
    end
  end

  # GET /purchase_orders/new
  # GET /purchase_orders/new.xml
  def new
    if request.post?
      # 从参数提取用户选择的 vendor id 和 vendor product id
      @vendor = Vendor.find(params[:vendor_id])
      vendor_product_ids = params[:vendor_products] || { }
      selected_vendor_products = vendor_product_ids.map { |key, val| VendorProduct.find(key) }
      selected_vendor_products.sort! { |x, y| x.title <=> y.title}

      # 创建 purchase order，并创建其中的 item
      @purchase_order = PurchaseOrder.new(:vendor_id => @vendor.id)
      selected_vendor_products.each do |vendor_product|
        @purchase_order.purchase_order_items <<
          PurchaseOrderItem.new(:vendor_product_id => vendor_product.id,
                                :unit_price => vendor_product.price,
                                :quantity => 1)
      end

      # 提取当前 vendor 的 product 供 View 的下拉列表使用
      @vendor_products = @vendor.vendor_products

      # 提取 customer 列表供 View 的下拉列表使用
      @customers = Customer.find(:all).sort

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
    # 检查本单货物是否都卖给一个顾客
    saled = params[:order_status][:saled] == "yes" ? true : false
    customer_id = params[:sale_order][:customer_id]

    begin
      PurchaseOrder.transaction do
        # 先保存进货单，save! 方法在验证失败时会扔出 exeption
        @purchase_order.save!

        # 如果本单货物都卖给一个客户，创建并保存销售单
        if saled
          @sale_order = SaleOrder.new
          @sale_order.customer_id = customer_id
          @sale_order.saled_at = @purchase_order.arrived_at
          @sale_order.postage = 0.0
          @purchase_order.purchase_order_items.each do |purchase_order_item|
            @sale_order.sale_order_items <<
              SaleOrderItem.new(:purchase_order_item_id => purchase_order_item.id,
                                :unit_price => purchase_order_item.unit_cost,
                                :quantity => purchase_order_item.quantity)
          end
          @sale_order.save!
        end
      end
    rescue
      respond_to do |format|
        flash[:notice] = "Failed to generate the purchase order: " +
          "#{@purchase_order.errors.full_messages.uniq.join(';')}. " +
          "Exception: #{$!.message}"
        format.html { redirect_to :controller => "store", :action => "purchase" }
        format.xml  { render :xml => @purchase_order.errors, :status => :unprocessable_entity }
      end
    else
      respond_to do |format|
        flash[:notice] = 'The purchase order was successfully created.'
        if saled
          format.html { redirect_to(edit_sale_order_path(@sale_order)) }
        else
          format.html { redirect_to(@purchase_order) }
        end
        format.xml  { render :xml => @purchase_order, :status => :created,
          :location => @purchase_order }
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

  def update_all

    purchase_orders = PurchaseOrder.find(:all)
    updated = 0
    begin
      purchase_orders.each do |order|
        order.save
        updated += 1
      end
    rescue => ex
      logger.warn "Failed to update purchase orders."
    ensure
      render :text => "Updated #{updated}/#{purchase_orders.size} purchase orders!"
    end
  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.xml
  def destroy
    @purchase_order = PurchaseOrder.find(params[:id])

    unless @purchase_order.destroy
      flash[:notice] = @purchase_order.errors.full_messages
    end

    respond_to do |format|
      format.html { redirect_to(purchase_orders_url) }
      format.xml  { head :ok }
    end
  end
end
