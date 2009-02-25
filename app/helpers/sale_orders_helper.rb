module SaleOrdersHelper
  def add_vendor_product_item_link(name, vendor_product_items)
    link_to_function name do |page|
      page.insert_html :bottom, :vendor_product_items, :partial => 'vendor_product_item',
                       :locals => { :vendor_product_items => vendor_product_items },
                       :object => SaleOrderItem.new(:quantity => 1)
    end
  end

  def add_store_product_item_link(name, store_product_items)
    link_to_function name do |page|
      page.insert_html :bottom, :store_product_items, :partial => 'store_product_item',
                       :locals => { :store_product_items => store_product_items },
                       :object => SaledStoreProductItem.new(:quantity => 1)
    end
  end
end
