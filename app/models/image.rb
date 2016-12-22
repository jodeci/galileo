# frozen_string_literal: true
class Image < ApplicationRecord
  mount_uploader :file, ImageUploader
  serialize :exif
end
