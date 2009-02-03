require 'test_helper'

class StoreItemsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:store_items)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_store_item
    assert_difference('StoreItem.count') do
      post :create, :store_item => { }
    end

    assert_redirected_to store_item_path(assigns(:store_item))
  end

  def test_should_show_store_item
    get :show, :id => store_items(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => store_items(:one).id
    assert_response :success
  end

  def test_should_update_store_item
    put :update, :id => store_items(:one).id, :store_item => { }
    assert_redirected_to store_item_path(assigns(:store_item))
  end

  def test_should_destroy_store_item
    assert_difference('StoreItem.count', -1) do
      delete :destroy, :id => store_items(:one).id
    end

    assert_redirected_to store_items_path
  end
end
