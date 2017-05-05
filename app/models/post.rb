# frozen_string_literal: true
class Post < ApplicationRecord
  include FriendlyId
  friendly_id :slug, use: [:slugged, :finders]
  acts_as_taggable

  enum status: { draft: 1, password_protected: 2, published: 3 }

  scope :tagged, -> { includes(:taggings) }
  scope :dashboard, -> { tagged.order(id: :desc) }

  scope :listed, -> {
    tagged
      .where(status: [:published, :password_protected])
      .order(published_at: :desc)
  }

  scope :featured, -> {
    where(status: :published, featured: true)
      .order(published_at: :desc)
  }

  def to_param
    id.to_s
  end
end
