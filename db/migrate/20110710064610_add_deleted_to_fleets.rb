class AddDeletedToFleets < ActiveRecord::Migration
  def self.up
    add_column :fleets, :deleted, :boolean
  end

  def self.down
    remove_column :fleets, :deleted
  end
end
