# frozen_string_literal: true
class Image < ApplicationRecord
  has_one_attached :file
  acts_as_taggable

  scope :tagged, -> { includes(:taggings) }
  scope :dashboard, -> { tagged.order(id: :desc) }

  class << self
    def fetch(id)
      Image.find_by(id: id) || NullImage
    end
  end
end
