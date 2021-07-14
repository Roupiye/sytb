class Musics::Card::Component < ApplicationComponent
  def initialize(music:, playlist: nil)
    @music = music
    @playlist = playlist
  end
end
