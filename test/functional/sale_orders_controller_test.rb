require File.dirname(__FILE__) + '/../test_helper'

class SaleOrdersControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_orders)
  end

  def test_should_get_new
    get :new
    assert_response 302
    assert_redirected_to :controller => "store", :action => "sale"
    assert_equal "Please select some products to create a sale order.",
                 flash[:notice]
  end

  def test_should_create_sale_order
    assert_difference('SaleOrder.count') do
      post :create, :sale_order => { :customer_id => 1,
                                     :saled_at    => "2009-02-10",
                                     :postage     => 9.0}
    end

    assert_redirected_to sale_order_path(assigns(:sale_order))
  end

  def test_should_show_sale_order
    get :show, :id => sale_orders(:sale_to_mike).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => sale_orders(:sale_to_mike).id
    assert_response :success
  end

  def test_should_update_sale_order
    put :update, :id => sale_orders(:sale_to_mike).id, :sale_order => { }
    assert_redirected_to sale_order_path(assigns(:sale_order))
  end

  def test_should_destroy_sale_order
    assert_difference('SaleOrder.count', -1) do
      delete :destroy, :id => sale_orders(:sale_to_mike).id
    end

    assert_redirected_to sale_orders_path
  end
end
