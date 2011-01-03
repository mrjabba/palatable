class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |t|
      t.string :title
      t.string :url
      t.string :tags
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :bookmarks
  end
end
