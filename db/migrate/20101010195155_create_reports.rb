class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :char_name
      t.string :solar_system_name
      t.integer :reds
      t.integer :neutrals

      t.timestamps
    end
    add_index :reports, :solar_system_name, :unique => true
  end

  def self.down
    drop_table :reports
  end
end
