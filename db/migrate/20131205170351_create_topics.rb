class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :url
      t.text :memo

      t.timestamps
    end
  end
end
