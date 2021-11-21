class AddCachedPlainTextDescriptionToPins < ActiveRecord::Migration[6.1]
  def change
    add_column :pins, :cached_plain_text_description, :text
  end
end
