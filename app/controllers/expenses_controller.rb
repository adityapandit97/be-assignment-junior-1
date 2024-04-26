class ExpensesController < ApplicationController

  def add_expense  
    ActiveRecord::Base.transaction do
      expense = Expense.new(user_id: params[:paid_by],amount: params[:expense_amount].to_i,date: params[:expense_date],description: params[:expense_description]
      )  
      if expense.save
        return redirect_to root_path, notice: 'Add at least one user mandatory !!' unless params[:expense_share].present?
       
        expense_shares = params[:expense_share].permit!.to_h
        expense_shares.each do |index, share_params|
          ExpensesShare.create(expense_id: expense.id,user_id: share_params[:user],amount: share_params[:amount],item_name: params[:expense_description],shared_equally: 0
          )  
          user_id = params[:paid_by].to_i == current_user.id ? params[:paid_by].to_i : share_params[:user].to_i
          friend_id = params[:paid_by].to_i == current_user.id ? share_params[:user].to_i : params[:paid_by].to_i
  
          data = get_frienship(user_id, friend_id)
          check_friendship_data(data)
          data.amount_to_take += share_params[:amount].to_i
          data.save
        end  
        redirect_to root_path, notice: 'Expense created successfully!'
      else
        redirect_to root_path, notice: 'Failed to create expense. Please try again.'
      end
    end
  end

  def settle_up
    data = get_frienship(params[:friendId], current_user.id)
    amount = data.amount_to_take.to_i
    settle_amount = params[:amount].to_i
    
    remaining_amount = amount - settle_amount
    if remaining_amount < 0
      data.update(amount_to_take: 0)
      data = get_frienship(current_user.id, params[:friendId])
      original_amount= data.amount_to_take
      data.update(amount_to_take: (remaining_amount.abs+original_amount))
    else
      data.update(amount_to_take: remaining_amount)
    end
    redirect_to root_path, notice: 'Settle Up successfully !!'
  end

  private

  def get_frienship(user_id, friend_id)
    Friendship.find_by(user_id: user_id,friend_id: friend_id)
  end

  def check_friendship_data(data)
    unless data.present?
      ExpensesShare.last.destroy
      Expense.last.destroy
      return redirect_to root_path, notice: 'No friendship exists !!'
    end
  end
end