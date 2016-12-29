# frozen_string_literal: true
class Image < ApplicationRecord
  mount_uploader :file, ImageUploader
  serialize :exif
  acts_as_taggable

  def self.fetch(id)
    Image.find_by(id: id) || NullImage
  end

  def exif_data
    return unless exif
    "#{exif[:date_time].strftime('%Y-%m-%d')} #{exif[:make]} #{exif[:model]} #{exif[:focal_length].to_i}mm f/#{exif[:f_number].to_f} #{exif[:exposure_time]} iso#{exif[:iso_speed_ratings]}"
  end

  def large_url
    file.large.url
  end

  def medium_url
    file.medium.url
  end

  def thumb_url
    file.thumb.url
  end
end
