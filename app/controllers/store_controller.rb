# -*- coding: utf-8 -*-
class StoreController < ApplicationController
  def index
    @total_purchases = PurchaseOrder.total_cost
    of_orders = PurchaseOrder.find(:all,
                                   :conditions => ["vendor_id = ?", 1])
    @total_of_purchases = of_orders.inject(0.0) do |sum, i|
      sum += i.total_cost
    end
    @total_spa_ppa_purchases = @total_purchases - @total_of_purchases

    @total_sales = SaleOrder.total_price
    @total_vendor_product_sales = SaleOrderItem.total_saled_price
    @total_store_product_sales  = SaledStoreProductItem.total_saled_price

    @total_materials = MaterialItem.total_cost

    @total_on_sale_cost = PurchaseOrderItem.total_on_sale_cost

    @total_profit = SaleOrder.total_profit
    @total_used_cost = UsedMaterialItem.total_used_cost
  rescue => ex
    logger.warn "\n\n========================================================="
    logger.warn "Expection in /store/index"
    logger.warn ex.message
    logger.warn ex.backtrace.inject("") { |msg, line| msg += "#{line}\n" }
    logger.warn "=========================================================\n\n"
    flash[:notice] = "Failed to get statistical data: #{ex.message}"
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
    @sale_orders = SaleOrder.find(:all, :order => "saled_at DESC")
  end

  def sys_info
    @info_properties = []

    # Rails 信息
    if defined? Rails::Info
      @info_properties += Rails::Info.properties
    end

    # Ruby Gems 信息
    # @info_properties << ['Loaded Gems', $".join("; ")]

    # MySQL 配置信息
    find_data = `find /etc -name "my.cnf"`
    unless find_data.blank?
      @info_properties << ['MySQL Configuration File', find_data.strip]
      if File.exist? find_data.strip
        socket_file = File.open(find_data.strip).grep /^socket.*=/
        @info_properties << ['MySQL Socket File', socket_file]
      end
    end
  end

  def dump
    send_data(DbDumper.to_mysql, :type => "plain/text",
              :disposition => "inline",
              :filename => Time.now.strftime("%Y-%m-%d_%H_%M_%S.sql"))
  end
end
