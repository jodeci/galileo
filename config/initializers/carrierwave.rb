if defined?(CarrierWave)
  CarrierWave.configure do |config|
    # config.asset_host = "http://localhost:3000"
  end

  if Rails.env.test?
    ImageUploader

    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?
      klass.class_eval do
        def cache_dir
          "#{Rails.root}/spec/support/uploads/tmp"
        end 

        def store_dir
          "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
      end
    end 
  end 
end
