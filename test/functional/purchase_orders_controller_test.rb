require File.dirname(__FILE__) + '/../test_helper'

class PurchaseOrdersControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_orders)
  end

  def test_get_new_should_redirect
    get :new
    assert_redirected_to :controller => "store", :action => "purchase"
    assert_equal "Please select some products to create a purchase order.",
                 flash[:notice]
  end

  def test_should_create_purchase_order
    assert_difference('PurchaseOrder.count') do
      post :create, :purchase_order => { :vendor_id    => 1,
                                         :purchased_at => "2009-02-10"}
    end

    assert_redirected_to purchase_order_path(assigns(:purchase_order))
  end

  def test_should_show_purchase_order
    get :show, :id => purchase_orders(:purchase_from_ppa).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => purchase_orders(:purchase_from_ppa).id
    assert_response :success
  end

  def test_should_update_purchase_order
    put :update, :id => purchase_orders(:purchase_from_ppa).id, :purchase_order => { }
    assert_redirected_to purchase_order_path(assigns(:purchase_order))
  end

  def test_should_destroy_purchase_order
    assert_difference('PurchaseOrder.count', -1) do
      delete :destroy, :id => purchase_orders(:purchase_from_ppa).id
    end

    assert_redirected_to purchase_orders_path
  end
end
