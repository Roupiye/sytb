# frozen_string_literal: true

class AddStatusToMusic < ActiveRecord::Migration[6.1]
  def change
    add_column :musics, :status, :integer, default: 0
  end
end
