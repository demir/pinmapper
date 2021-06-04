class CreateCrops < ActiveRecord::Migration[6.1]
  def change
    create_table :crops do |t|
      t.integer :cropable_id
      t.string :cropable_type
      t.string :crop_x
      t.string :crop_y
      t.string :crop_width
      t.string :crop_height

      t.timestamps
    end
    add_index :crops, %i[cropable_type cropable_id]
  end
end
