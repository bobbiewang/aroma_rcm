require File.dirname(__FILE__) + '/../test_helper'

class StoreControllerTest < ActionController::TestCase
  def test_should_get_purchase
    get :purchase
    assert_response :success
  end

  def test_should_get_sale
    get :sale
    assert_response :success
  end
end
