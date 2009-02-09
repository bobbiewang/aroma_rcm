module PurchaseOrdersHelper
  def add_store_item_link(name, vendor_products)
    link_to_function name do |page|
      page.insert_html :bottom, :purchase_order_items, :partial => 'purchase_order_item',
                       :locals => { :vendor_products => vendor_products },
                       :object => PurchaseOrderItem.new(:quantity => 1)
    end
  end
end
