class CreatePinBoardSections < ActiveRecord::Migration[7.0]
  def change
    create_table :pin_board_sections do |t|
      t.references :pin, null: false, foreign_key: true
      t.references :board_section, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
