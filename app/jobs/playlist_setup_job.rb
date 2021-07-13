class PlaylistSetupJob < ApplicationJob
  queue_as :urgent

  def perform(playlist)
    yt_playlist = Yt::Playlist.new id: playlist.code

    yt_playlist.playlist_items.map do |item|
      Music.create playlist: playlist, code: item.video_id, link: "https://youtu.be/#{item.video_id}"
    end
  end
end
