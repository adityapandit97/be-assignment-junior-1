# test/models/user_test.rb
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user has many friendships" do
    association = User.reflect_on_association(:friendships)
    assert_equal :has_many, association.macro
  end

  test "user has many expenses" do
    association = User.reflect_on_association(:expenses)
    assert_equal :has_many, association.macro
  end

  test "user has many expense shares" do
    association = User.reflect_on_association(:expenses_shares)
    assert_equal :has_many, association.macro
  end

  test "user has many friends through friendships" do
    association = User.reflect_on_association(:friends)
    assert_equal :has_many, association.macro
    assert_equal :friend, association.options[:source]
  end

  test "user is valid with valid attributes" do
    user = User.new(email: "test@example.com", password: "password")
    assert user.valid?
  end

  test "user is not valid without an email" do
    user = User.new(password: "password")
    assert_not user.valid?
  end

  test "user is not valid without a password" do
    user = User.new(email: "test@example.com")
    assert_not user.valid?
  end
end
