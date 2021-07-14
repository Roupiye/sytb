class Playlist < ApplicationRecord
  enum status: [:waiting, :done, :processing, :aborted]

  has_many :playlist_musics
  has_many :musics, through: :playlist_musics
  has_one_attached :thumbnail

  after_commit :set_playlist, on: [:create]

  def set_playlist
    PlaylistSetupJob.perform_later self
  end
end
