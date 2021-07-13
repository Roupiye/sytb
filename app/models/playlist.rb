class Playlist < ApplicationRecord
  has_many :musics

  after_commit :set_playlist, on: [:create]

  def set_playlist
    puts "test"
    puts code

    playlist = Yt::Playlist.new id: code
    puts playlist

    playlist.playlist_items.map do |item|
      puts item.video_id
      music = Music.create playlist: self, code: item.video_id, link: "https://youtu.be/#{item.video_id}"
      puts music
    end
  end
end
