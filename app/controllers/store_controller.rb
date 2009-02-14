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

  def dump
    db_name, user, password = params[:db_name], params[:user], params[:password]
    unless [db_name, user, password].any? { |item| item.nil? }

      header = <<END_OF_HEADER
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
CREATE DATABASE `#{db_name}` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `#{db_name}`;

END_OF_HEADER

      dump_data = `mysqldump -u #{user} --password=#{password} #{db_name} 2>&1`
      send_data(header + dump_data, :type => "plain/text",
                :disposition => "inline",
                :filename => Time.now.strftime("%Y-%m-%d_%H_%M_%S.sql"))
    else
      render :text => "mysqldump -u #{user} --password=#{password} #{db_name} 2>&1"
    end
  end
end
