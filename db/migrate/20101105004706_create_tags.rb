class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :text, :null => false
      t.integer :usage_count, :null => false, :default => '0'
      t.boolean :favorite

      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
