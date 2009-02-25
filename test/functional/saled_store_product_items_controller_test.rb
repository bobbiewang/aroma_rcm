require File.dirname(__FILE__) + '/../test_helper'

class SaledStoreProductItemsControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:saled_store_product_items)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_saled_store_product_item
    assert_difference('SaledStoreProductItem.count') do
      post :create, :saled_store_product_item => { :sale_order_id => 1,
                                                   :store_product_item_id => 1,
                                                   :item_cost => 9.9,
                                                   :item_price => 9.9,
                                                   :quantity => 1 }
    end

    assert_redirected_to saled_store_product_item_path(assigns(:saled_store_product_item))
  end

  def test_should_show_saled_store_product_item
    get :show, :id => saled_store_product_items(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => saled_store_product_items(:one).id
    assert_response :success
  end

  def test_should_update_saled_store_product_item
    put :update, :id => saled_store_product_items(:one).id, :saled_store_product_item => { }
    assert_redirected_to saled_store_product_item_path(assigns(:saled_store_product_item))
  end

  def test_should_destroy_saled_store_product_item
    assert_difference('SaledStoreProductItem.count', -1) do
      delete :destroy, :id => saled_store_product_items(:one).id
    end

    assert_redirected_to saled_store_product_items_path
  end
end
