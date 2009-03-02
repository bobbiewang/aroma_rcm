# -*- coding: utf-8 -*-
class MaterialsController < ApplicationController
  def index
    @material_items = MaterialItem.find(:all)
  end

  def order
    @items = PurchaseOrderItem.avail_items.select do |item|
      item.avail_quantity > 0
    end
  end

  def new
    items = params[:material_items] || { }

    if request.post? and items.size != 0
      @material_items = { }
      items.each_key do |id|
        poi = PurchaseOrderItem.find(id)
        mi = MaterialItem.new(:purchase_order_id => poi.purchase_order_id,
                              :vendor_product_id => poi.vendor_product_id,
                              :item_price => poi.unit_price,
                              :item_cost => poi.unit_cost,
                              :quantity => 1)
        @material_items[mi] = poi
      end
    else
      flash[:notice] = 'Please select some items first.'
      redirect_to :action => 'order'
    end
  end

  def create
    items = params[:item] || []
    items.each do |item|
      PurchaseOrderItem.transaction do
        poi = PurchaseOrderItem.find(item['purchase_order_item_id'])
        # 减少 PurchaseOrderItem 的数量
        next if poi.avail_quantity < item['quantity'].to_i
        poi.quantity -= item['quantity'].to_i
        # 如果 PurchaseOrderItem 的数量为 0，删除 PurchaseOrderItem
        if poi.quantity == 0
          poi.destroy
        else
          poi.save
        end
        # 创建 MaterialItem
        MaterialItem.create(:purchase_order_id => item['purchase_order_id'],
                            :vendor_product_id => item['vendor_product_id'],
                            :item_price => item['item_price'],
                            :item_cost => item['item_cost'],
                            :quantity => item['quantity'],
                            :usedup => false)
      end
    end
    redirect_to :action => 'index'
  end
end
