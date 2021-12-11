class AddCountersToUsers < ActiveRecord::Migration[6.1]
  def self.up
    add_column :users, :pins_count, :integer, null: false, default: 0
    add_column :users, :boards_count, :integer, null: false, default: 0
    add_column :users, :public_boards_count, :integer, null: false, default: 0
    add_column :users, :secret_boards_count, :integer, null: false, default: 0
    add_column :users, :following_count, :integer, null: false, default: 0
    add_column :users, :followers_count, :integer, null: false, default: 0
    add_column :users, :tags_count, :integer, null: false, default: 0
    add_column :users, :following_boards_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :users, :pins_count
    remove_column :users, :boards_count
    remove_column :users, :public_boards_count
    remove_column :users, :secret_boards_count
    remove_column :users, :following_count
    remove_column :users, :followers_count
    remove_column :users, :tags_count
    remove_column :users, :following_boards_count
  end
end
