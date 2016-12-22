# frozen_string_literal: true
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file
  process :auto_orient
  process :store_exif_data

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :large do
    process resize_to_limit: [800, 800]
  end

  version :medium, from_version: :large do
    process resize_to_limit: [500, 500]
  end

  version :thumb, from_version: :medium do
    process resize_to_fill: [100, 100]
  end

  private

  def auto_orient
    manipulate! do |img|
      img.auto_orient
      img
    end
  end

  def store_exif_data
    return unless file and model
    model.exif = EXIFR::JPEG.new(self.file.file).to_hash
  end
end