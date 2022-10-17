class AddPositionToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :position, :integer
  end
end
