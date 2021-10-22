class CreatePinBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :pin_boards do |t|
      t.references :pin, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
