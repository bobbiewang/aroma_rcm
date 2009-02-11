require File.dirname(__FILE__) + '/../test_helper'

class VendorsControllerTest < ActionController::TestCase
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

  def test_should_create_vendor
    assert_difference('Vendor.count') do
      post :create, :vendor => { :full_name   => "test",
                                 :abbr_name   => "test",
                                 :currency_id => 1,
                                 :active      => true }
    end

    assert_redirected_to vendor_path(assigns(:vendor))
  end

  def test_should_show_vendor
    get :show, :id => vendors(:ppa).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => vendors(:ppa).id
    assert_response :success
  end

  def test_should_update_vendor
    put :update, :id => vendors(:ppa).id, :vendor => { }
    assert_redirected_to vendor_path(assigns(:vendor))
  end

  def test_should_destroy_vendor
    assert_difference('Vendor.count', -1) do
      delete :destroy, :id => vendors(:ppa).id
    end

    assert_redirected_to vendors_path
  end
end
