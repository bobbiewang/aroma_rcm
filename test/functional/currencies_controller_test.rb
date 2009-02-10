require File.dirname(__FILE__) + '/../test_helper'

class CurrenciesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:currencies)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_currency
    assert_difference('Currency.count') do
      post :create, :currency => { :full_name => "test name",
                                   :iso_code  => "test",
                                   :symbol    => "t" }
    end

    assert_redirected_to currency_path(assigns(:currency))
  end

  def test_should_show_currency
    get :show, :id => currencies(:cny).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => currencies(:cny).id
    assert_response :success
  end

  def test_should_update_currency
    put :update, :id => currencies(:cny).id, :currency => { }
    assert_redirected_to currency_path(assigns(:currency))
  end

  def test_should_destroy_currency
    assert_difference('Currency.count', -1) do
      delete :destroy, :id => currencies(:cny).id
    end

    assert_redirected_to currencies_path
  end
end
