# test/models/expenses_share_test.rb
require 'test_helper'

class ExpensesShareTest < ActiveSupport::TestCase
  test "expenses share is valid with valid attributes" do
    user = User.create(email: "test@example.com", password: "password")
    expense = Expense.create(description: "Test expense", amount: 100, user: user)
    expenses_share = ExpensesShare.new(expense: expense, user: user, amount: 50)
    assert expenses_share.valid?
  end

  test "expenses share is not valid without an amount" do
    user = User.create(email: "test@example.com", password: "password")
    expense = Expense.create(description: "Test expense", amount: 100, user: user)
    expenses_share = ExpensesShare.new(expense: expense, user: user)
    assert_not expenses_share.valid?
  end

  test "expenses share is not valid with a negative amount" do
    user = User.create(email: "test@example.com", password: "password")
    expense = Expense.create(description: "Test expense", amount: 100, user: user)
    expenses_share = ExpensesShare.new(expense: expense, user: user, amount: -50)
    assert_not expenses_share.valid?
  end

  test "expenses share is not valid without an expense" do
    user = User.create(email: "test@example.com", password: "password")
    expenses_share = ExpensesShare.new(user: user, amount: 50)
    assert_not expenses_share.valid?
  end

  test "expenses share is not valid without a user" do
    expense = Expense.create(description: "Test expense", amount: 100)
    expenses_share = ExpensesShare.new(expense: expense, amount: 50)
    assert_not expenses_share.valid?
  end
end
