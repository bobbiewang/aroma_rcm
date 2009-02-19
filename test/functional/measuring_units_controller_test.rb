require File.dirname(__FILE__) + '/../test_helper'

class MeasuringUnitsControllerTest < ActionController::TestCase
  def setup
    get :index, { }, { :user_id => users(:admin).id }
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:measuring_units)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_measuring_unit
    assert_difference('MeasuringUnit.count') do
      post :create, :measuring_unit => { :full_name => 'test',
                                         :abbr_name => 'tt',
                                         :precision => 0 }
    end

    assert_redirected_to measuring_unit_path(assigns(:measuring_unit))
  end

  def test_should_show_measuring_unit
    get :show, :id => measuring_units(:ml).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => measuring_units(:ml).id
    assert_response :success
  end

  def test_should_update_measuring_unit
    put :update, :id => measuring_units(:ml).id, :measuring_unit => { }
    assert_redirected_to measuring_unit_path(assigns(:measuring_unit))
  end

  def test_should_destroy_measuring_unit
    assert_difference('MeasuringUnit.count', -1) do
      delete :destroy, :id => measuring_units(:ml).id
    end

    assert_redirected_to measuring_units_path
  end
end
