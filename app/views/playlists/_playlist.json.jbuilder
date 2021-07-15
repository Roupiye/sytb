# frozen_string_literal: true

json.extract! playlist, :id, :title, :code, :created_at, :updated_at
json.url playlist_url(playlist, format: :json)
