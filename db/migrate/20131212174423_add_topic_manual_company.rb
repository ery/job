class AddTopicManualCompany < ActiveRecord::Migration
  def change
    add_column :topics, :manual_company, :string
  end
end
