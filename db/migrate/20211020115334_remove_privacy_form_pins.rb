class RemovePrivacyFormPins < ActiveRecord::Migration[6.1]
  def change
    remove_column :pins, :privacy, :integer
  end
end
