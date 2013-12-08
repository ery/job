class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.string :url
      t.string :status, :default => Subject::Status::INBOX
      t.string :manual_salary
      t.string :manual_memo
      t.timestamps
    end
  end
end
