class RenameDescriptionToDescriptionOldInBoards < ActiveRecord::Migration[7.0]
  def change
    rename_column :boards, :description, :description_old
  end
end
