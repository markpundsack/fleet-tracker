class RemoveUniquenessOfSystemInReport < ActiveRecord::Migration
  def self.up
    remove_index :reports, :solar_system_name
    add_index :reports, :solar_system_name
  end

  def self.down
    remove_index :reports, :solar_system_name
    add_index :reports, :solar_system_name, :unique => true
  end
end
