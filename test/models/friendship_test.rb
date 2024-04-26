require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  test "should belong to a user" do
    user = User.create(email: "user@example.com", password: "password")
    friend = User.create(email: "friend@example.com", password: "password")
    friendship = Friendship.new(user: user, friend: friend)
    
    assert_instance_of User, friendship.user
  end

  test "should belong to a friend" do
    user = User.create(email: "user@example.com", password: "password")
    friend = User.create(email: "friend@example.com", password: "password")
    friendship = Friendship.new(user: user, friend: friend)
    
    assert_instance_of User, friendship.friend
  end

  test "friend association should be of class User" do
    assert_equal User, Friendship.reflect_on_association(:friend).klass
  end

  test "user association should be of class User" do
    assert_equal User, Friendship.reflect_on_association(:user).klass
  end
end
