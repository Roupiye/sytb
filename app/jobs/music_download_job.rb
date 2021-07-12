require "open-uri"

class MusicDownloadJob < ApplicationJob
  queue_as :default

  def perform(music)
    @music = music
    @mp3 = download_video

    download_thumbnail
    strip_video if @music.start || @music.end

    @music.title = @mp3.information[:title]
    @music.artist = @mp3.information[:artist]
    @music.duration = @mp3.information[:duration]
    @music.mp3.attach(io: File.open("#{@music.id}.mp3"), filename: "#{@music.id}.mp3")
    @music.thumbnail.attach(io: File.open("#{@music.id}_thumb"), filename: "#{@music.id}_thumb")
    @music.save

    File.delete("#{@music.id}_thumb") if File.exist?("#{@music.id}_thumb")
    File.delete("_#{@music.id}.mp3") if File.exist?("_#{@music.id}_thumb")
    File.delete("#{@music.id}.mp3") if File.exist?("#{@music.id}.mp3")
  end

  private

  def download_video
    YoutubeDL.download(
      @music.link,
      output: "#{@music.id}.%(ext)s",
      format: "bestaudio",
      audio_format: "mp3",
      extract_audio: true
    )
  end

  def strip_video
    `mv #{@music.id}.mp3 _#{@music.id}.mp3`
    `ffmpeg -y -i _#{@music.id}.mp3 -ss #{@music.start.blank? ? "00:00:00" : @music.start} #{"-t #{@music.end}" unless @music.end.blank?} #{@music.id}.mp3`
  end

  def download_thumbnail
    File.open("#{@music.id}_thumb", "wb") do |fo|
      fo.write open(@mp3.information[:thumbnails].last[:url]).read
    end
  end
end
