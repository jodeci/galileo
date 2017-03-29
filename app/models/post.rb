# frozen_string_literal: true
class Post < ApplicationRecord
  include FriendlyId
  friendly_id :slug, use: [:slugged, :finders]
  acts_as_taggable

  enum status: { draft: 1, password_protected: 2, published: 3 }

  validates :title, presence: true
  validates :slug, presence: true
  validates :slug, uniqueness: { message: I18n.t("validation.uniqueness") }
  validates :slug, format: { with: %r{\A[a-zA-Z0-9_-]+\z}, message: I18n.t("validation.format.slug"), allow_blank: true }
  validates :cover_image, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :published_at, presence: { message: I18n.t("validation.post.published_at") }, unless: :draft?
  validate :feature_only_published, if: :featured?

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

  private

  def feature_only_published
    return if published?
    errors.add(:featured, I18n.t("validation.post.featured"))
  end
end
