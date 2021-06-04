class CreatePins < ActiveRecord::Migration[6.1]
  def change
    create_table :pins do |t|
      t.string :name
      t.string :address
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.integer :category
      t.integer :privacy
      t.text :cover_image_description

      t.timestamps
    end
  end
end
