if defined?(CarrierWave)
  ImageUploader
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        if Rails.env.test?
          "spec/support/uploads/tmp"
        else
          "uploads/tmp"
        end
      end 

      def store_dir
        if Rails.env.test?
          "spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        else
          "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
      end 
    end 
  end 
end
