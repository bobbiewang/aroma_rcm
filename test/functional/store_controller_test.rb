require File.dirname(__FILE__) + '/../test_helper'

class StoreControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_login
    get :login
    assert_response :success
  end

  def test_index_without_user
    get :logout
    get :index
    assert_redirected_to :action => "login"
    assert_equal "Please log in", flash[:notice]
  end

  def test_should_get_purchase
    get :purchase
    assert_response :success
  end

  def test_should_get_sale
    get :sale
    assert_response :success
  end
end
