class RenameCoverImageDescriptionToCoverPhotoDescriptionInPins < ActiveRecord::Migration[6.1]
  def change
    rename_column :pins, :cover_image_description, :cover_photo_description
  end
end
