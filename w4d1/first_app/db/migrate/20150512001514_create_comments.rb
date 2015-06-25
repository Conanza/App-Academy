class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.integer :author_id

      t.integer :commentable_id, index: true # This is an ID
      t.string :commentable_type # This is the name of a class => table
      # t.references :commentable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
