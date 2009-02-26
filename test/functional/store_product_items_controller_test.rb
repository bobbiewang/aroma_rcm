require File.dirname(__FILE__) + '/../test_helper'

class StoreProductItemsControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:store_product_items)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_store_product_item
    assert_difference('StoreProductItem.count') do
      post :create, :store_product_item => { :store_product_id => 1,
                                             :quantity => 8 }
    end

    assert_redirected_to store_product_item_path(assigns(:store_product_item))
  end

  def test_should_show_store_product_item
    get :show, :id => store_product_items(:one_cream).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => store_product_items(:one_cream).id
    assert_response :success
  end

  def test_should_update_store_product_item
    put :update, :id => store_product_items(:one_cream).id, :store_product_item => { }
    assert_redirected_to store_product_item_path(assigns(:store_product_item))
  end

  def test_should_destroy_store_product_item
    assert_difference('StoreProductItem.count', -1) do
      delete :destroy, :id => store_product_items(:one_cream).id
    end

    assert_redirected_to store_product_items_path
  end

  def test_should_get_onsale
    get :onsale
    assert_response :success
    assert_not_nil assigns(:onsale_items)
    assert_equal 2, assigns(:onsale_items).size
  end
end
