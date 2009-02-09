class SaleOrderItemsController < ApplicationController
  # GET /sale_order_items
  # GET /sale_order_items.xml
  def index
    @sale_order_items = SaleOrderItem.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sale_order_items }
    end
  end

  # GET /sale_order_items/1
  # GET /sale_order_items/1.xml
  def show
    @sale_order_item = SaleOrderItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sale_order_item }
    end
  end

  # GET /sale_order_items/new
  # GET /sale_order_items/new.xml
  def new
    @sale_order_item = SaleOrderItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sale_order_item }
    end
  end

  # GET /sale_order_items/1/edit
  def edit
    @sale_order_item = SaleOrderItem.find(params[:id])
  end

  # POST /sale_order_items
  # POST /sale_order_items.xml
  def create
    @sale_order_item = SaleOrderItem.new(params[:sale_order_item])

    respond_to do |format|
      if @sale_order_item.save
        flash[:notice] = 'SaleOrderItem was successfully created.'
        format.html { redirect_to(@sale_order_item) }
        format.xml  { render :xml => @sale_order_item, :status => :created, :location => @sale_order_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sale_order_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sale_order_items/1
  # PUT /sale_order_items/1.xml
  def update
    @sale_order_item = SaleOrderItem.find(params[:id])

    respond_to do |format|
      if @sale_order_item.update_attributes(params[:sale_order_item])
        flash[:notice] = 'SaleOrderItem was successfully updated.'
        format.html { redirect_to(@sale_order_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sale_order_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_order_items/1
  # DELETE /sale_order_items/1.xml
  def destroy
    @sale_order_item = SaleOrderItem.find(params[:id])
    @sale_order_item.destroy

    respond_to do |format|
      format.html { redirect_to(sale_order_items_url) }
      format.xml  { head :ok }
    end
  end
end
