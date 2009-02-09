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
    @sale_order = SaleOrder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sale_order }
    end
  end

  # GET /sale_orders/1/edit
  def edit
    @sale_order = SaleOrder.find(params[:id])
  end

  # POST /sale_orders
  # POST /sale_orders.xml
  def create
    @sale_order = SaleOrder.new(params[:sale_order])

    respond_to do |format|
      if @sale_order.save
        flash[:notice] = 'SaleOrder was successfully created.'
        format.html { redirect_to(@sale_order) }
        format.xml  { render :xml => @sale_order, :status => :created, :location => @sale_order }
      else
        format.html { render :action => "new" }
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
