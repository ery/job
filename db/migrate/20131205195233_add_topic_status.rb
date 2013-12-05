class AddTopicStatus < ActiveRecord::Migration
  def change
    add_column :topics, :status, :string, :default => Topic::Status::INBOX
  end
end
