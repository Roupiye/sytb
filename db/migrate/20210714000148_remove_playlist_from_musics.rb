class RemovePlaylistFromMusics < ActiveRecord::Migration[6.1]
  def change
    remove_reference :musics, :playlist, index: true, foreign_key: true
  end
end
