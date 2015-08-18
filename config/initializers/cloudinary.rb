Cloudinary.config do |config|
  config.cloud_name = 'pancherry29'
  config.api_key = ENV['CLOUDINARY_APP_KEY']
  config.api_secret = ENV['CLOUDINARY_API_SECRET']
  config.cdn_subdomain = true
end