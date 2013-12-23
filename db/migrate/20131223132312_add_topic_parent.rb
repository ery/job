class AddTopicParent < ActiveRecord::Migration
  def change
    add_column :topics, :parent_id, :integer
  end
end