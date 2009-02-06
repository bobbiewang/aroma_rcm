module PurchaseOrdersHelper
  def add_store_item_link(name, vendor_products)
    link_to_function name do |page|
      page.insert_html :bottom, :store_items, :partial => 'purchase_order_store_item',
                       :locals => { :vendor_products => vendor_products },
                       :object => StoreItem.new(:sale_quantity => 1)
    end
  end
end
