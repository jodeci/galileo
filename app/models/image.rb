# frozen_string_literal: true
class Image < ApplicationRecord
  mount_uploader :file, ImageUploader
  serialize :exif
  acts_as_taggable

  class << self
    def fetch(id)
      Image.find_by(id: id) || NullImage
    end

    def fetch_url(*args)
      fetch(args[0]).file.url(file_size(args[1]))
    end

    private

    def file_size(size)
      if size.in?(file_versions)
        size
      else
        "medium"
      end
    end

    def file_versions
      ImageUploader.versions.keys.map(&:to_s)
    end
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
