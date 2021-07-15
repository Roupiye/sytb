# frozen_string_literal: true

require "open-uri"

class MusicDownloadJob < ApplicationJob
  include CableReady::Broadcaster
  delegate :render, to: :ApplicationController
  queue_as :default

  def perform(music)
    @music = music
    clean_up

    begin
      update_status :downloading
      @mp3 = download_video
      download_thumbnail
      update_status :processing
      strip_video if @music.start || @music.end
    rescue => err
      @music.error = err.message
      update_status :aborted
      return
    end

    @music.title = @mp3.information[:title]
    @music.artist = @mp3.information[:artist]
    @music.duration = @mp3.information[:duration]
    @music.mp3.attach(io: File.open("#{@music.id}.mp3"), filename: "#{@music.id}.mp3")
    @music.thumbnail.attach(io: File.open("#{@music.id}_thumb"), filename: "#{@music.id}_thumb")

    update_status :done

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

  def update_status(status)
    @music.status = status
    @music.save

    cable_ready["application-stream"].outer_html(
      selector: "#music_#{@music.id}",
      html: ApplicationController.render(Musics::Card::Component.new(music: @music), layout: false)
    )
    cable_ready.broadcast
  end
end
