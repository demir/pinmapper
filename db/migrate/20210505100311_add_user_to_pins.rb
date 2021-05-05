class AddUserToPins < ActiveRecord::Migration[6.1]
  def change
    add_reference :pins, :user, null: false, foreign_key: true
  end
end
