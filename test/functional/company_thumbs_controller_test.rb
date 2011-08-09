require 'test_helper'

class CompanyThumbsControllerTest < ActionController::TestCase
  setup do
    @company_thumb = company_thumbs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_thumbs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_thumb" do
    assert_difference('CompanyThumb.count') do
      post :create, :company_thumb => @company_thumb.attributes
    end

    assert_redirected_to company_thumb_path(assigns(:company_thumb))
  end

  test "should show company_thumb" do
    get :show, :id => @company_thumb.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @company_thumb.to_param
    assert_response :success
  end

  test "should update company_thumb" do
    put :update, :id => @company_thumb.to_param, :company_thumb => @company_thumb.attributes
    assert_redirected_to company_thumb_path(assigns(:company_thumb))
  end

  test "should destroy company_thumb" do
    assert_difference('CompanyThumb.count', -1) do
      delete :destroy, :id => @company_thumb.to_param
    end

    assert_redirected_to company_thumbs_path
  end
end
