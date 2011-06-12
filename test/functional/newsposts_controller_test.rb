require 'test_helper'

class NewspostsControllerTest < ActionController::TestCase
  setup do
    @newspost = newsposts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newsposts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newspost" do
    assert_difference('Newspost.count') do
      post :create, :newspost => @newspost.attributes
    end

    assert_redirected_to newspost_path(assigns(:newspost))
  end

  test "should show newspost" do
    get :show, :id => @newspost.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @newspost.to_param
    assert_response :success
  end

  test "should update newspost" do
    put :update, :id => @newspost.to_param, :newspost => @newspost.attributes
    assert_redirected_to newspost_path(assigns(:newspost))
  end

  test "should destroy newspost" do
    assert_difference('Newspost.count', -1) do
      delete :destroy, :id => @newspost.to_param
    end

    assert_redirected_to newsposts_path
  end
end
