require File.dirname(__FILE__) + '/../test_helper'

class MaterialItemsControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:material_items)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_material_item
    assert_difference('MaterialItem.count') do
      post :create, :material_item => { :purchase_order_id => 1,
                                        :vendor_product_id => 1,
                                        :item_price => 9.99,
                                        :item_cost => 9.99,
                                        :quantity => 1,
                                        :usedup => false }
    end

    assert_redirected_to material_item_path(assigns(:material_item))
  end

  def test_should_show_material_items
    get :show, :id => material_items(:purchase_2_ppa_oil).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => material_items(:purchase_2_ppa_oil).id
    assert_response :success
  end

  def test_should_update_material_items
    put :update, :id => material_items(:purchase_2_ppa_oil).id, :material_items => { }
    assert_redirected_to material_item_path(assigns(:material_item))
  end

  def test_should_destroy_material_items
    assert_difference('MaterialItem.count', -1) do
      delete :destroy, :id => material_items(:purchase_2_ppa_oil).id
    end

    assert_redirected_to material_items_path
  end
end
