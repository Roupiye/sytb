class Musics::List::Content::Component < ApplicationComponent
  def initialize(musics:, playlist:)
    @musics = musics
    @playlist = playlist
  end
end
