# frozen_string_literal: true

class PlaylistMusic < ApplicationRecord
  belongs_to :playlist
  belongs_to :music
end
