# app/models/expense.rb
class Expense < ApplicationRecord
 
    belongs_to :user, class_name: "User"
    has_many :expense_shares, class_name: "ExpensesShare"
  
    enum split_type: { equal: 0, itemized: 1 }
  
    validates :description, presence: true
    validates :amount, numericality: { greater_than: 0 }
    validates :user_id, presence: true
  
  end
  