# frozen_string_literal: true
class Post < ApplicationRecord
  include FriendlyId
  friendly_id :slug, use: [:slugged, :finders]
  acts_as_taggable

  validates :title, presence: true
  validates :slug, presence: true
  validates :slug, uniqueness: { message: I18n.t("validation.uniqueness") }
  validates :slug, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: I18n.t("validation.format.slug"), allow_blank: true }
  validates :cover_image, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validate :published_at_unless_draft

  scope :published, -> {
    where("status IN (?)", %w(public protected))
      .where("published_at IS NOT NULL")
      .order(published_at: :desc)
  }

  scope :featured, -> {
    where(status: "public")
      .where("published_at IS NOT NULL")
      .order(published_at: :desc)
      .limit(5)
  }

  def public?
    status == "public"
  end

  def protected?
    status == "protected"
  end

  def draft?
    status == "draft"
  end

  private

  def published_at_unless_draft
    return if draft?
    if published_at.blank?
      errors.add(:published_at, I18n.t("validation.post.published_at_unless_draft"))
    end
  end
end
