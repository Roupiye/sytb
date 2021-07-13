# frozen_string_literal: true

Rails.application.routes.draw do
  resources :playlists
  resources :musics

  root to: "playlists#index"
end
