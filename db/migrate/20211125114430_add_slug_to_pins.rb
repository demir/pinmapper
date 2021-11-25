class AddSlugToPins < ActiveRecord::Migration[6.1]
  def change
    add_column :pins, :slug, :string
    add_index :pins, :slug, unique: true
  end
end
