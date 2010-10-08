class AddScopeToFleets < ActiveRecord::Migration
  def self.up
    add_column :fleets, :scope, :integer
  end

  def self.down
    remove_column :fleets, :scope
  end
end
