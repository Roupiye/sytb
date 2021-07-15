# frozen_string_literal: true

class AddCodeToMusic < ActiveRecord::Migration[6.1]
  def change
    add_column :musics, :code, :string
  end
end
