class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :orginal_id
      t.string :url
      t.string :author
      t.string :author_url
      t.string :local_file
      t.timestamps
    end
  end
end
