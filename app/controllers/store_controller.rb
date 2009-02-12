class StoreController < ApplicationController
  def index
    @total_on_sale_cost = PurchaseOrderItem.total_on_sale_cost
    @total_profit = PurchaseOrderItem.total_profit
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :action => "index" })
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => "login"
  end

  def purchase
    @vendors = Vendor.find(:all, :conditions => ["active = ?", true])
  end

  def purchase_history
    @purchase_orders = PurchaseOrder.find(:all, :order => "purchased_at DESC")
  end

  def sale
    @items = PurchaseOrderItem.avail_items
  end

  def sale_history
    @sale_orders = SaleOrder.find(:all, :order => "saled_at")
  end
end
