class CreateTopicTags < ActiveRecord::Migration
  def change
    create_table :topic_tags do |t|
      t.references :topic, :null => false
      t.references :tag,   :null => false
    end
  end
end
