class Playlists::Card::Component < ApplicationComponent
  def initialize(playlist:)
    @playlist = playlist
  end
end
