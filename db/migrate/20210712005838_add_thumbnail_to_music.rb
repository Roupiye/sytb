class AddThumbnailToMusic < ActiveRecord::Migration[6.1]
  def change
    add_column :musics, :thumbnail, :string
  end
end
