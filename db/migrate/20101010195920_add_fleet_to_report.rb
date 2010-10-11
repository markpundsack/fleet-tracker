class AddFleetToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :fleet_id, :integer
  end

  def self.down
    remove_column :reports, :fleet_id
  end
end
