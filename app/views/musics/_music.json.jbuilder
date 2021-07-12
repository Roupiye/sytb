# frozen_string_literal: true

json.extract! music, :id, :title, :link, :created_at, :updated_at
json.url music_url(music, format: :json)
