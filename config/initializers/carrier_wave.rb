if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV["AWS_ACCESS_KEY"],
      :aws_secret_access_key  => ENV["AWS_SECRET_KEY"]
    }
    config.fog_directory  = 'danielkeeton-production'
    config.fog_public     = false
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  end
elsif Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
    config.store_dir = "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
elsif Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end