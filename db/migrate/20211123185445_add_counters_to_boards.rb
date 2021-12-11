class AddCountersToBoards < ActiveRecord::Migration[6.1]
  def self.up
    add_column :boards, :pins_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :boards, :pins_count
  end
end
