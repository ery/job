class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :url
      t.string :file
      t.timestamps
    end
  end
end
