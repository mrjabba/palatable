class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end
    remove_column :bookmarks, :tags
  end

  def self.down
    drop_table :tags
    add_column :bookmarks, :tags, :string
  end
end
