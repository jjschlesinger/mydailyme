require File.dirname(__FILE__) + '/../test_helper'

class MesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:mes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_me
    assert_difference('Me.count') do
      post :create, :me => { }
    end

    assert_redirected_to me_path(assigns(:me))
  end

  def test_should_show_me
    get :show, :id => mes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => mes(:one).id
    assert_response :success
  end

  def test_should_update_me
    put :update, :id => mes(:one).id, :me => { }
    assert_redirected_to me_path(assigns(:me))
  end

  def test_should_destroy_me
    assert_difference('Me.count', -1) do
      delete :destroy, :id => mes(:one).id
    end

    assert_redirected_to mes_path
  end
end
