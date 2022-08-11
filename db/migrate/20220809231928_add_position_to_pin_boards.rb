class AddPositionToPinBoards < ActiveRecord::Migration[6.1]
  def change
    add_column :pin_boards, :position, :integer
  end
end
