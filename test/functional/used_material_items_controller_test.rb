require File.dirname(__FILE__) + '/../test_helper'

class UsedMaterialItemsControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:used_material_items)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_used_material_item
    assert_difference('UsedMaterialItem.count') do
      post :create, :used_material_item => { :material_item_id => 1,
                                             :store_product_item_id => 1,
                                             :amount => 1 }
    end

    assert_redirected_to used_material_item_path(assigns(:used_material_item))
  end

  def test_should_show_used_material_item
    get :show, :id => used_material_items(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => used_material_items(:one).id
    assert_response :success
  end

  def test_should_update_used_material_item
    put :update, :id => used_material_items(:one).id, :used_material_item => { }
    assert_redirected_to used_material_item_path(assigns(:used_material_item))
  end

  def test_should_destroy_used_material_item
    assert_difference('UsedMaterialItem.count', -1) do
      delete :destroy, :id => used_material_items(:one).id
    end

    assert_redirected_to used_material_items_path
  end
end
