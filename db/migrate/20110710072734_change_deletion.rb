class ChangeDeletion < ActiveRecord::Migration
  def self.up
    add_column :fleets, :deleted_at, :time
    remove_column :fleets, :deleted
  end

  def self.down
    remove_column :fleets, :deleted_at
    add_column :fleets, :deleted, :boolean, :default => false
  end
end
