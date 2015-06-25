class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :url_id
      t.integer :topic_id

      t.timestamps
    end
  end
end
