class AddUniqueIndex < ActiveRecord::Migration
  def change
    add_index :topics,     :url,                 unique: true
    add_index :topics,     :file,                unique: true
    add_index :tags,       :name,                unique: true
    add_index :topic_tags, [:topic_id, :tag_id], unique: true
  end
end
