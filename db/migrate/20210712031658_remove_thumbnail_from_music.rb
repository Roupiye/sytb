# frozen_string_literal: true

class RemoveThumbnailFromMusic < ActiveRecord::Migration[6.1]
  def change
    remove_column :musics, :thumbnail, :string
  end
end
