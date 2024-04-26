
require 'test_helper'

class ExpensesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @user = users(:one) # Assuming you have fixture data for users
    @friend = users(:two)
    sign_in @user # Sign in the user
  end

  test "should create expense and share correctly" do
    Friendship.update(user_id: @user.id,friend_id: @friend.id)
    post :add_expense, params: { 
      paid_by: @user.id,
      expense_amount: 100,
      expense_date: Date.today,
      expense_description: 'Test expense',
      expense_share: {
        '0' => { user: @friend.id, amount: 50 }
      }
    }
    assert_redirected_to root_path
    assert_equal 'Expense created successfully!', flash[:notice]
    assert_equal 50, Friendship.find_by(user_id: @user.id, friend_id: @friend.id).amount_to_take
  end

  test "should settle up correctly" do
    Friendship.first.update(user_id: @friend.id ,friend_id: @user.id)
    Friendship.create(user_id: @user.id ,friend_id: @friend.id)
    post :settle_up, params: { friendId: @friend.id, amount: 50 }

    assert_redirected_to root_path
    assert_equal 'Settle Up successfully !!', flash[:notice]
    assert_equal 50, Friendship.find_by(user_id: @user.id, friend_id: @friend.id).amount_to_take
  end
end
