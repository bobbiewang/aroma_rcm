require File.dirname(__FILE__) + '/../test_helper'

class SaleOrderItemsControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_order_items)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_sale_order_item
    assert_difference('SaleOrderItem.count') do
      post :create, :sale_order_item => { :sale_order_id          => 1,
                                          :purchase_order_item_id => 1,
                                          :unit_cost              => 9.9,
                                          :unit_price             => 9.0,
                                          :quantity               => 1 }
    end

    assert_redirected_to sale_order_item_path(assigns(:sale_order_item))
  end

  def test_should_show_sale_order_item
    get :show, :id => sale_order_items(:sale_oil_to_mike).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => sale_order_items(:sale_oil_to_mike).id
    assert_response :success
  end

  def test_should_update_sale_order_item
    put :update, :id => sale_order_items(:sale_oil_to_mike).id, :sale_order_item => { }
    assert_redirected_to sale_order_item_path(assigns(:sale_order_item))
  end

  def test_should_destroy_sale_order_item
    assert_difference('SaleOrderItem.count', -1) do
      delete :destroy, :id => sale_order_items(:sale_oil_to_mike).id
    end

    assert_redirected_to sale_order_items_path
  end
end
