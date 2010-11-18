class AddTagIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :tag_id, :integer
  end

  def self.down
    remove_column :users, :tag_id
  end
end
