class Music < ApplicationRecord
  enum status: [:waiting, :done, :processing, :downloading, :aborted]
  after_commit :set_music, on: [:create]

  belongs_to :playlist
  has_one_attached :mp3
  has_one_attached :thumbnail

  def set_music
    MusicDownloadJob.perform_later(self)
  end
end
