module StoreProductItemsHelper
  def add_used_material_item_link(name, material_items)
    link_to_function name do |page|
      page.insert_html :bottom, :used_material_items, :partial => 'used_material_item',
                       :locals => { :material_items => material_items },
                       :object => UsedMaterialItem.new(:amount => 1)
    end
  end
end
