class CreateBoardSections < ActiveRecord::Migration[7.0]
  def change
    create_table :board_sections do |t|
      t.string :name
      t.references :board, null: false, foreign_key: true
      t.integer :pins_count, null: false, default: 0
      t.string :slug
      t.integer :position

      t.timestamps
    end
  end
end
