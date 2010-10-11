class FixUniquenessOfSysteInReport < ActiveRecord::Migration
  def self.up
    remove_index :reports, :solar_system_name
    add_index :reports, [:solar_system_name, :fleet_id], :unique => true
  end

  def self.down
  end
end
