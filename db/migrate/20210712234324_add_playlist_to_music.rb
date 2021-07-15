# frozen_string_literal: true

class AddPlaylistToMusic < ActiveRecord::Migration[6.1]
  def change
    add_reference :musics, :playlist, null: false, foreign_key: true
  end
end
