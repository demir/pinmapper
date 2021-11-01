class CreateUserBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :user_boards do |t|
      t.references :user, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
    add_index :user_boards, %i[user_id board_id], unique: true
  end
end
