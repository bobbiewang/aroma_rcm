require File.dirname(__FILE__) + '/../test_helper'

class MaterialsControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:material_items)
  end

  def test_should_get_order
    get :order
    assert_response :success
    assert_not_nil assigns(:items)
  end

  def test_should_not_get_new
    get :new
    assert_response :redirect
  end

  def test_should_not_post_new_with_nil_items
    post :new
    assert_response :redirect

    post :new, :non_items => { }
    assert_response :redirect
  end

  def test_should_post_new_with_items
    post :new, :material_items => { 1 => 1 }
    assert_response :success
    assert_equal 1, assigns(:material_items).size
  end

  def test_should_create
    assert_difference('MaterialItem.count', 2) do
      assert_difference('PurchaseOrderItem.count', -1) do
        post :create, :item => [
                                { "purchase_order_id" => "1",
                                  "vendor_product_id" => "1",
                                  "item_price" => "4.44",
                                  "item_cost" => "8.88",
                                  "quantity" =>
                                  purchase_order_items(:purchase_4_ppa_oil).quantity - 1,
                                  "purchase_order_item_id" =>
                                  purchase_order_items(:purchase_4_ppa_oil).id },
                                { "purchase_order_id" => "1",
                                  "vendor_product_id" => "2",
                                  "item_price" => "3.33",
                                  "item_cost" => "7.77",
                                  "quantity" =>
                                  purchase_order_items(:purchase_10_ppa_box).quantity,
                                  "purchase_order_item_id" =>
                                  purchase_order_items(:purchase_10_ppa_box).id}
                               ]
      end
    end

    # 一个 PurchaseOrderItem 减少了数量， 一个被删除
    assert_equal 1, PurchaseOrderItem.find(purchase_order_items(:purchase_4_ppa_oil).id).quantity
    assert_raise ActiveRecord::RecordNotFound do
      PurchaseOrderItem.find(purchase_order_items(:purchase_10_ppa_box).id)
    end

    # 完成后重定向，创建了两个 MaterialItem 记录
    assert_redirected_to :action => "index"
    assert_equal 2, assigns(:material_items).size
  end
end
