# frozen_string_literal: true

class Music < ApplicationRecord
  enum status: [:waiting, :done, :processing, :downloading, :aborted]
  after_commit :set_music, on: [:create]

  has_many :playlist_musics, dependent: :destroy
  has_many :playlists, through: :playlist_musics

  has_one_attached :mp3
  has_one_attached :thumbnail

  # has_one :thumbnail, -> { where(name: 'image') }, class_name: "ActiveStorage::Attachment", as: :record, inverse_of: :record, dependent: false
  # has_one :thumbnail_blob, through: :image_attachment", class_name: "ActiveStorage::Blob", source: :blob

  def set_music
    MusicDownloadJob.perform_later(self)
  end
end
