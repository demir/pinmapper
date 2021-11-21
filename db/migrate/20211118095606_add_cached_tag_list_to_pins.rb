class AddCachedTagListToPins < ActiveRecord::Migration[6.1]
  def change
    add_column :pins, :cached_tag_list, :string
  end
end
