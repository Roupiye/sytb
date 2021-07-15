# frozen_string_literal: true

class Musics::Viewer::Component < ApplicationComponent
  def initialize(music: nil)
    @music = music
  end

  def render?
    @music
  end
end
