class AddDirectAccessToFleet < ActiveRecord::Migration
  def self.up
    add_column :fleets, :direct_access, :boolean
  end

  def self.down
    remove_column :fleets, :direct_access
  end
end
