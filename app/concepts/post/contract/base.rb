# frozen_string_literal: true
require "reform/form/validation/unique_validator"
require "reform/form/coercion"

module Post::Contract
  class Base < Reform::Form
    feature Coercion

    property :title
    property :slug
    property :body
    property :abstract
    property :cover_image
    property :status
    property :published_at
    property :featured, type: Types::Form::Bool
    property :tag_list

    validates :title, presence: true
    validates :slug, presence: true
    validates :slug, unique: { message: I18n.t("validation.uniqueness") }
    validates :slug, format: { with: %r{\A[a-zA-Z0-9_-]+\z}, message: I18n.t("validation.format.slug") }
    validates :cover_image, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
    validate :published_at_unless_draft
    validate :featured_only_published

    def published_at_unless_draft
      return if status == "draft"
      return if published_at.present?
      errors.add(:published_at, I18n.t("validation.post.published_at"))
    end

    def featured_only_published
      return unless featured
      return if status == "published"
      errors.add(:featured, I18n.t("validation.post.featured"))
    end
  end

  class Create < Base
  end

  class Update < Base
  end
end
