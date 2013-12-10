class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :url
      t.string :file
      t.string :status, :default => Topic::Status::NONE
      t.string :analyzed_salary
      t.string :analyzed_author
      t.string :manual_salary
      t.string :manual_memo
      t.timestamps
    end
  end
end