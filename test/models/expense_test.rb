# test/models/expense_test.rb
require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  test "expense is valid with valid attributes" do
    user = User.create(email: "test@example.com", password: "password")
    expense = Expense.new(description: "Test expense", amount: 100, user: user)
    assert expense.valid?
  end

  test "expense is not valid without a description" do
    expense = Expense.new(amount: 100)
    assert_not expense.valid?
  end

  test "expense is not valid with a non-positive amount" do
    user = User.create(email: "test@example.com", password: "password")
    expense = Expense.new(description: "Test expense", amount: 0, user: user)
    assert_not expense.valid?
  end

  test "expense is not valid without a user" do
    expense = Expense.new(description: "Test expense", amount: 100)
    assert_not expense.valid?
  end

  test "expense belongs to a user" do
    association = Expense.reflect_on_association(:user)
    assert_equal :belongs_to, association.macro
  end

  test "expense has many expense shares" do
    association = Expense.reflect_on_association(:expense_shares)
    assert_equal :has_many, association.macro
    assert_equal "ExpensesShare", association.options[:class_name]
  end

  test "defines split_type enum with values equal and itemized" do
    assert_equal({ equal: 0, itemized: 1 }, Expense.split_types)
  end
end
