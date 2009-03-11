require File.dirname(__FILE__) + '/../test_helper'

class StoreProductsControllerTest < ActionController::TestCase
  def setup
    get :edit, { :id => store_products(:cream) }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:store_products)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_store_product
    assert_difference('StoreProduct.count') do
      post :create, :store_product => { :title => 'test' }
    end

    assert_redirected_to store_product_path(assigns(:store_product))
  end

  def test_should_show_store_product
    get :show, :id => store_products(:cream).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => store_products(:cream).id
    assert_response :success
  end

  def test_should_update_store_product
    put :update, :id => store_products(:cream).id, :store_product => { }
    assert_redirected_to store_product_path(assigns(:store_product))
  end

  def test_should_destroy_store_product
    assert_difference('StoreProduct.count', -1) do
      delete :destroy, :id => store_products(:cream).id
    end

    assert_redirected_to store_products_path
  end

  def test_should_get_raw
    get :raw
    assert_response :success
    assert_not_nil assigns(:store_products)
  end
end
