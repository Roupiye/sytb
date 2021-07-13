Yt.configuration.api_key = Rails.application.credentials[:yt_key]

Yt.configure do |config|
  config.log_level = :debug
end
