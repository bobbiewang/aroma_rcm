require File.dirname(__FILE__) + '/../test_helper'

class VendorProductsControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:vendors)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_vendor_product
    assert_difference('VendorProduct.count') do
      post :create, :vendor_product => { :title     => "test",
                                         :vendor_id => 1,
                                         :measuring_unit_id => 1,
                                         :material_amount => 1,
                                         :active    => true}
    end

    assert_redirected_to vendor_product_path(assigns(:vendor_product))
  end

  def test_should_show_vendor_product
    get :show, :id => vendor_products(:oil).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => vendor_products(:oil).id
    assert_response :success
  end

  def test_should_update_vendor_product
    put :update, :id => vendor_products(:oil).id, :vendor_product => { }
    assert_redirected_to vendor_product_path(assigns(:vendor_product))
  end

  def test_should_destroy_vendor_product
    assert_difference('VendorProduct.count', -1) do
      delete :destroy, :id => vendor_products(:oil).id
    end

    assert_redirected_to vendor_products_path
  end
end
