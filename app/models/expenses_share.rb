class ExpensesShare < ApplicationRecord
    belongs_to :expense
    belongs_to :user
  
    validates :amount, numericality: { greater_than_or_equal_to: 0 }
    validates :expense_id, presence: true
    validates :user_id, presence: true
  end
  