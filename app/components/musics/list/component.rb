class Musics::List::Component < ApplicationComponent
  def initialize(musics:, playlist:, offset: musics.size)
    @musics = musics
    @playlist = playlist
    @offset = offset
  end
end
