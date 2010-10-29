class CreateGlobalAdmins < ActiveRecord::Migration
  def self.up
    create_table :global_admins do |t|
      t.string :char_name

      t.timestamps
    end
  end

  def self.down
    drop_table :global_admins
  end
end
