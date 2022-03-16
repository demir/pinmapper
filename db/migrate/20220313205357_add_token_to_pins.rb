class AddTokenToPins < ActiveRecord::Migration[6.1]
  def change
    add_column :pins, :token, :string
    add_index :pins, :token, unique: true
  end
end
