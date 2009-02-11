require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_user
    assert_difference('User.count') do
      post :create, :user => { :name => "test",
                               :password => "test",
                               :password_confirmation => "test"}
    end

    assert_redirected_to user_path(assigns(:user))
  end

  def test_should_show_user
    get :show, :id => users(:admin).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => users(:admin).id
    assert_response :success
  end

  def test_should_update_user
    put :update, :id => users(:admin).id, :user => { }
    assert_redirected_to user_path(assigns(:user))
  end

  def test_should_destroy_user
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:admin).id
    end

    assert_redirected_to users_path
  end
end
