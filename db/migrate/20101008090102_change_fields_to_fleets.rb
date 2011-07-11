class ChangeFieldsToFleets < ActiveRecord::Migration
  def self.up
    add_column :fleets, :created_by, :string
    add_column :fleets, :corp_name, :string
    add_column :fleets, :alliance_name, :string
    #remove_column :fleets, :user_id
  end

  def self.down
    remove_column :fleets, :created_by
    remove_column :fleets, :corp_name
    remove_column :fleets, :alliance_name
    add_column :fleets, :user_id, :integer
  end
end
