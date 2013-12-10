class AddAnalyzedCompany < ActiveRecord::Migration
  def change
    add_column :topics, :analyzed_company, :string
  end
end
