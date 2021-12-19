class AddGenresToArtist < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :genres, :text, array:true, default: []
  end
end
