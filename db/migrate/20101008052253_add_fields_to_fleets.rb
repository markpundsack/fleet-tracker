class AddFieldsToFleets < ActiveRecord::Migration
  def self.up
    add_column :fleets, :display_pilot_count, :boolean
    add_column :fleets, :display_fc_info, :boolean
    add_column :fleets, :fc, :string
    add_column :fleets, :xo, :string
  end

  def self.down
    remove_column :fleets, :xo
    remove_column :fleets, :fc
    remove_column :fleets, :display_fc_info
    remove_column :fleets, :display_pilot_count
  end
end
