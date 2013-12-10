class AddTopicColumns < ActiveRecord::Migration
  def change
    add_column :topics, :status,        :string, :default => Subject::Status::INBOX
    add_column :topics, :manual_salary, :string
    add_column :topics, :manual_memo,   :string
  end
end