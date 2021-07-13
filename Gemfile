# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "rails", "~> 6.1.4"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
# gem 'bcrypt', '~> 3.1.7'
gem 'image_processing', '~> 1.2'
gem "bootsnap", ">= 1.4.4", require: false

gem "redis", "~> 4.0", require: ["redis", "redis/connection/hiredis"]
gem "hiredis"
gem "view_component"
gem "cable_ready", "~> 5.0.pre1"
gem "stimulus_reflex", "~> 3.5.0-pre1"
gem "octicons_helper"
gem "youtube-dl.rb", github: "Realvestor/youtube-dl.rb", branch: "fix/update-binary"
gem 'yt'
gem 'simple_form'
gem 'hotwire-rails'

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 4.1.0"
  gem "rack-mini-profiler", "~> 2.0"
  gem "listen", "~> 3.3"
  gem "spring"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

