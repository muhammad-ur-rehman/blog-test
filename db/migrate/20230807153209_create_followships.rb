class CreateFollowships < ActiveRecord::Migration[6.1]
  def change
    create_table :followships do |t|
      t.references :follower, foreign_key: { to_table: :users }, null: false
      t.references :followed, foreign_key: { to_table: :posts }, null: false

      t.timestamps
    end

    add_index :followships, [:follower_id, :followed_id], unique: true
  end
end
