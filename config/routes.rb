# frozen_string_literal: true

Rails.application.routes.draw do
  resources :playlists
  resources :musics

  get "/player", to: "musics#player_viewer", as: "player_viewer"

  root to: "playlists#index"
end
