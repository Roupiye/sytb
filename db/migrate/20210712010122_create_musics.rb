class CreateMusics < ActiveRecord::Migration[6.1]
  def change
    create_table :musics do |t|
      t.string :title
      t.string :link
      t.string :thumbnail
      t.integer :duration
      t.string :artist

      t.timestamps
    end
  end
end
