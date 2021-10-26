class AddIndexToPinBoards < ActiveRecord::Migration[6.1]
  def change
    add_index :pin_boards, %i[pin_id board_id], unique: true
  end
end
