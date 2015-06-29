class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :bands, :name

    create_table :albums do |t|
      t.string :title, null: false
      t.string :album_type, null: false
      t.integer :band_id, null: false

      t.timestamps
    end

    add_index :albums, :title
    add_index :albums, :band_id

    create_table :tracks do |t|
      t.string :song, null: false
      t.text :lyrics
      t.string :track_type, null: false
      t.integer :album_id, null: false

      t.timestamps
    end

    add_index :tracks, :song
    add_index :tracks, :album_id
  end
end
