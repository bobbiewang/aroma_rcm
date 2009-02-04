module PurchaseOrdersHelper
  def add_store_item_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :store_items, :partial => 'purchase_order_store_item' , :object => StoreItem.new
    end
  end
end
