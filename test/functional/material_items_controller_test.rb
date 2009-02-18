require 'test_helper'

class MaterialItemsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:material_items)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_material_items
    assert_difference('MaterialItems.count') do
      post :create, :material_items => { }
    end

    assert_redirected_to material_items_path(assigns(:material_items))
  end

  def test_should_show_material_items
    get :show, :id => material_items(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => material_items(:one).id
    assert_response :success
  end

  def test_should_update_material_items
    put :update, :id => material_items(:one).id, :material_items => { }
    assert_redirected_to material_items_path(assigns(:material_items))
  end

  def test_should_destroy_material_items
    assert_difference('MaterialItems.count', -1) do
      delete :destroy, :id => material_items(:one).id
    end

    assert_redirected_to material_items_path
  end
end
