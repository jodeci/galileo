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

  scope :published, -> {
    where("status IN (?)", %w(public protected))
      .where("published_at IS NOT NULL")
      .order(published_at: :desc)
  }

  def accessible?
    if status == "public"
      true
    else
      false # TODO: based on session password
    end
  end
end
