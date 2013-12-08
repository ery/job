class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.string :url
      t.string :status, :default => Subject::Status::INBOX
      t.string :analyzed_salary
      t.string :manual_salary
      t.string :memo
      t.timestamps
    end
  end
end
