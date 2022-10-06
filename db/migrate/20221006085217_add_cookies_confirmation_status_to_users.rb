class AddCookiesConfirmationStatusToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :cookies_confirmation_status, :integer, default: 0
  end
end
