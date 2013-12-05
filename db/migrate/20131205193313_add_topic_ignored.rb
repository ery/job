class AddTopicIgnored < ActiveRecord::Migration
  def change
    add_column :topics, :is_ignored, :boolean, :default => false
  end
end
