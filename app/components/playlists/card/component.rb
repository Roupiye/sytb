# frozen_string_literal: true

class Playlists::Card::Component < ApplicationComponent
  def initialize(playlist:)
    @playlist = playlist
  end
end
