class AddIndexToUsers < ActiveRecord::Migration
  def self.up
    add_index :users, :char_name, :unique => true
    add_index :global_admins, :char_name, :unique => true
  end

  def self.down
    remove_index :users, :char_name
    remove_index :global_admins, :char_name
  end
end
