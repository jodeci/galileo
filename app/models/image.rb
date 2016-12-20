# frozen_string_literal: true
class Image < ApplicationRecord
  mount_uploader :info, ImageUploader
end
