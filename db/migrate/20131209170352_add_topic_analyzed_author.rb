class AddTopicAnalyzedAuthor < ActiveRecord::Migration
  def change
    add_column :topics, :analyzed_author, :string
  end
end
