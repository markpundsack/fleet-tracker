class AddDefaultToDeleted < ActiveRecord::Migration
  def self.up
    change_column :fleets, :deleted, :boolean, :default => false
  end

  def self.down
  end
end
