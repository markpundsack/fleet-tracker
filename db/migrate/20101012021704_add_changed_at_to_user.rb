
class AddChangedAtToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :changed_at, :datetime
  end

  def self.down
    remove_column :users, :changed_at
  end
end
