class AddErrorToMusics < ActiveRecord::Migration[6.1]
  def change
    add_column :musics, :error, :string
  end
end
