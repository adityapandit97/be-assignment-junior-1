class CreateExpensesShares < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses_shares do |t|
      
      t.references :expense, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :item_name
      t.boolean :shared_equally, default: false

      t.timestamps
    end
  end
end
