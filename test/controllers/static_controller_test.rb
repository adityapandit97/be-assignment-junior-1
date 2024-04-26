require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers # Include Devise test helpers

  def setup
    @user = users(:one)
    sign_in @user
  end

  test "should get dashboard" do
    get :dashboard
    assert_response :success
    assert_not_nil assigns(:users)
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:user_friends)
    assert_not_nil assigns(:expenses)
    assert_not_nil assigns(:bal1)
    assert_not_nil assigns(:bal2)
    assert_not_nil assigns(:expenses_share_not)
    assert_not_nil assigns(:expenses_share)
  end

  test "should get person" do
    friend = users(:two)
    get :person, params: { id: friend.id }
    assert_response :success
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:expenses_share)
  end

  test "should add friend" do
    friend = users(:two)
    post :add_friend, params: { user_id: friend.id }
    assert_redirected_to root_path
    assert_equal 'Friend added successfully!', flash[:notice]
    assert @user.friends.include?(friend)
  end
end
