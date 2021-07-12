class AddDurationToMusic < ActiveRecord::Migration[6.1]
  def change
    add_column :musics, :duration, :string
  end
end
