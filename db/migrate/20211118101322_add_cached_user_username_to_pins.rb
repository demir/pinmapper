class AddCachedUserUsernameToPins < ActiveRecord::Migration[6.1]
  def change
    add_column :pins, :cached_user_username, :string
  end
end
