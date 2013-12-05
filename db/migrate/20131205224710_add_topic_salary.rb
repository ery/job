class AddTopicSalary < ActiveRecord::Migration
  def change
    add_column :topics, :monthly_salary, :string
    add_column :topics, :annual_salary, :string
  end
end
