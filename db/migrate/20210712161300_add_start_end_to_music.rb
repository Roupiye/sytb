# frozen_string_literal: true

class AddStartEndToMusic < ActiveRecord::Migration[6.1]
  def change
    add_column :musics, :start, :string
    add_column :musics, :end, :string
  end
end
