class AddDescriptionToBoards < ActiveRecord::Migration[6.1]
  def change
    add_column :boards, :description, :text
  end
end
