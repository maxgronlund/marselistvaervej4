require 'test_helper'

class MeetingroomsControllerTest < ActionController::TestCase
  setup do
    @meetingroom = meetingrooms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meetingrooms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meetingroom" do
    assert_difference('Meetingroom.count') do
      post :create, :meetingroom => @meetingroom.attributes
    end

    assert_redirected_to meetingroom_path(assigns(:meetingroom))
  end

  test "should show meetingroom" do
    get :show, :id => @meetingroom.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @meetingroom.to_param
    assert_response :success
  end

  test "should update meetingroom" do
    put :update, :id => @meetingroom.to_param, :meetingroom => @meetingroom.attributes
    assert_redirected_to meetingroom_path(assigns(:meetingroom))
  end

  test "should destroy meetingroom" do
    assert_difference('Meetingroom.count', -1) do
      delete :destroy, :id => @meetingroom.to_param
    end

    assert_redirected_to meetingrooms_path
  end
end
