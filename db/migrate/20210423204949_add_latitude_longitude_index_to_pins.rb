class AddLatitudeLongitudeIndexToPins < ActiveRecord::Migration[6.1]
  def change
    add_index :pins, %i[latitude longitude]
  end
end
