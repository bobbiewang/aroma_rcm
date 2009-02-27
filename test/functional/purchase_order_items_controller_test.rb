require File.dirname(__FILE__) + '/../test_helper'

class PurchaseOrderItemsControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_order_items)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_purchase_order_item
    assert_difference('PurchaseOrderItem.count') do
      post :create, :purchase_order_item => { :purchase_order_id => 1,
                                              :vendor_product_id => 1,
                                              :quantity          => 1 }
    end

    assert_redirected_to purchase_order_item_path(assigns(:purchase_order_item))
  end

  def test_should_show_purchase_order_item
    get :show, :id => purchase_order_items(:purchase_4_ppa_oil).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => purchase_order_items(:purchase_4_ppa_oil).id
    assert_response :success
  end

  def test_should_update_purchase_order_item
    put :update, :id => purchase_order_items(:purchase_4_ppa_oil).id, :purchase_order_item => { }
    assert_redirected_to purchase_order_item_path(assigns(:purchase_order_item))
  end

  def test_should_destroy_purchase_order_item
    assert_difference('PurchaseOrderItem.count', -1) do
      delete :destroy, :id => purchase_order_items(:purchase_4_ppa_oil).id
    end

    assert_redirected_to purchase_order_items_path
  end

  def test_should_get_raw
    get :raw
    assert_response :success
    assert_not_nil assigns(:purchase_order_items)
  end
end
