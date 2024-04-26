class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :description, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.integer :split_type, default: 0
      
      t.datetime :date
      t.references :user, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end