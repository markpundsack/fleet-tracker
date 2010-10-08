class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :char_name
      t.string :corp_name
      t.string :alliance_name
      t.string :station_name
      t.string :solar_system_name
      t.string :constellation_name
      t.string :region_name

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
