class User < ApplicationRecord
  has_many :friendships
  has_many :expenses
  has_many :expenses_shares
  has_many :friends, through: :friendships, source: :friend

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
