require File.dirname(__FILE__) + '/../test_helper'

class MeSectionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:me_sections)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_me_section
    assert_difference('MeSection.count') do
      post :create, :me_section => { }
    end

    assert_redirected_to me_section_path(assigns(:me_section))
  end

  def test_should_show_me_section
    get :show, :id => me_sections(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => me_sections(:one).id
    assert_response :success
  end

  def test_should_update_me_section
    put :update, :id => me_sections(:one).id, :me_section => { }
    assert_redirected_to me_section_path(assigns(:me_section))
  end

  def test_should_destroy_me_section
    assert_difference('MeSection.count', -1) do
      delete :destroy, :id => me_sections(:one).id
    end

    assert_redirected_to me_sections_path
  end
end
