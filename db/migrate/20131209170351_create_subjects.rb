class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.string :url
      t.string :status, :default => Subject::Status::INBOX
      t.string :monthly_salary
      t.string :annual_salary
      t.text :memo
      t.timestamps
    end
  end
end
