class AddFleetToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :fleet_id, :integer
  end

  def self.down
    remove_column :users, :fleet_id
  end
end
