class AddUsersCountToFleets < ActiveRecord::Migration
  def self.up
    add_column :fleets, :users_count, :integer
    Fleet.reset_column_information
    Fleet.all.each { |f| Fleet.update_counters f.id, :users_count => f.users.count }
  end

  def self.down
    remove_column :fleets, :users_count
  end
end
