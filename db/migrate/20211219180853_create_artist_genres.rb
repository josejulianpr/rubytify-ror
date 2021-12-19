class CreateArtistGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :artist_genres do |t|
      t.belongs_to :artist, foreign_key: true
      t.belongs_to :genre, foreign_key: true

      t.timestamps
    end
  end
end
