class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :amount_to_take, default: 0


      t.timestamps
    end

    add_index :friendships, [:user_id, :friend_id], unique: true
  end
end