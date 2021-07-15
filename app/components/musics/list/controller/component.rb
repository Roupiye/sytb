# frozen_string_literal: true

class Musics::List::Controller::Component < ApplicationComponent
  def initialize(playlist:, offset:)
    @playlist = playlist
    @offset = offset
  end
end
