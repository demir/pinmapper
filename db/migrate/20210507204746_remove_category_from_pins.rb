class RemoveCategoryFromPins < ActiveRecord::Migration[6.1]
  def change
    remove_column :pins, :category, :integer
  end
end
