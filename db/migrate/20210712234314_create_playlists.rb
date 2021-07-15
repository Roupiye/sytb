# frozen_string_literal: true

class CreatePlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists do |t|
      t.string :title
      t.string :code

      t.timestamps
    end
  end
end
