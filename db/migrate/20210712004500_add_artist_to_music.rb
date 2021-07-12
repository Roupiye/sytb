class AddArtistToMusic < ActiveRecord::Migration[6.1]
  def change
    add_column :musics, :artist, :string
  end
end
