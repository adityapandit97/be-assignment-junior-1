class StaticController < ApplicationController

  def dashboard
    @user = current_user
    @users = User.all
    @user_friends = @user.friends
    @expenses = Expense.where(user_id: current_user.id)
  
    @bal1 = get_user_friendship.sum(:amount_to_take)
    @bal2 = get_own_friendship.sum(:amount_to_take)
  
    @expenses_share_not = get_own_friendship.pluck(:id).uniq
    @expenses_share = get_user_friendship.pluck(:id).uniq
  end

  def person
    @user = get_user(params[:id])
    @expenses_share = ExpensesShare.includes(:expense).where(user_id: @user.id, expenses: { user_id: current_user.id }).map do |share|
      [share, share.expense.amount]
    end.compact
  end

  def add_friend
    friend = get_user(params[:user_id])
    current_user.friends << friend
    redirect_to root_path, notice: 'Friend added successfully!'
  end

  private

  def get_user(id)
    User.find_by(id: id)
  end

  def get_user_friendship
    Friendship.where(user_id: current_user.id)
  end

  def get_own_friendship
    Friendship.where(friend_id: current_user.id)
  end
end