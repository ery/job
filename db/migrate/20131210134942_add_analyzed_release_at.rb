class AddAnalyzedReleaseAt < ActiveRecord::Migration
  def change
    add_column :topics, :analyzed_release_at, :datetime
  end
end
