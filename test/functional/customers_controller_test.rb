require File.dirname(__FILE__) + '/../test_helper'

class CustomersControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_customer
    assert_difference('Customer.count') do
      post :create, :customer => { :name => "test" }
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  def test_should_show_customer
    get :show, :id => customers(:mike).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => customers(:mike).id
    assert_response :success
  end

  def test_should_update_customer
    put :update, :id => customers(:mike).id, :customer => { }
    assert_redirected_to customer_path(assigns(:customer))
  end

  def test_should_destroy_customer
    assert_difference('Customer.count', -1) do
      delete :destroy, :id => customers(:mike).id
    end

    assert_redirected_to customers_path
  end

  def test_should_get_raw
    get :raw
    assert_response :success
    assert_not_nil assigns(:customers)
  end
end
