# frozen_string_literal: true
class Post < ApplicationRecord
  include FriendlyId
  friendly_id :slug, use: :slugged
  acts_as_taggable
  validates :slug, uniqueness: { message: I18n.t("validation.uniqueness") }
  validates :slug, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: I18n.t("validation.format.slug"), allow_blank: true }

  def markdownify
    RenderMarkdown.new(body).call
  end
end
