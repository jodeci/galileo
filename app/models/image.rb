# frozen_string_literal: true
class Image < ApplicationRecord
  mount_uploader :file, ImageUploader
  serialize :exif
  acts_as_taggable

  def self.fetch(id)
    Image.find_by(id: id) || NullImage
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
