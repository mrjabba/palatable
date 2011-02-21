class CreateBundles < ActiveRecord::Migration
  def self.up
    create_table :bundles do |t|
      t.integer :bookmark_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :bundles, [:bookmark_id, :tag_id]
  end

  def self.down
    drop_table :bundles
  end
end
