require "open-uri"

class MusicDownloadJob < ApplicationJob
  queue_as :default

  def perform(music)
    @music = music
    clean_up

    begin
      @mp3 = download_video
      download_thumbnail
      strip_video if @music.start || @music.end
    rescue
      @music.status = :aborted
      @music.save
      return
    end

    @music.title = @mp3.information[:title]
    @music.artist = @mp3.information[:artist]
    @music.duration = @mp3.information[:duration]
    @music.mp3.attach(io: File.open("#{@music.id}.mp3"), filename: "#{@music.id}.mp3")
    @music.thumbnail.attach(io: File.open("#{@music.id}_thumb"), filename: "#{@music.id}_thumb")
    @music.save

    clean_up
  end

  private

  def clean_up
    File.delete("#{@music.id}_thumb") if File.exist?("#{@music.id}_thumb")
    File.delete("_#{@music.id}.mp3") if File.exist?("_#{@music.id}.mp3")
    File.delete("#{@music.id}.mp3") if File.exist?("#{@music.id}.mp3")
  end

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

    start_param = "-ss #{@music.start || "00:00:00"}"
    end_param = "-t #{@music.end}" if @music.end

    `ffmpeg -y -i _#{@music.id}.mp3 #{start_param} #{end_param} #{@music.id}.mp3`
  end

  def download_thumbnail
    File.open("#{@music.id}_thumb", "wb") do |fo|
      fo.write open(@mp3.information[:thumbnails].last[:url]).read
    end
  end
end
