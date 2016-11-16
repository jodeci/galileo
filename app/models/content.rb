# frozen_string_literal: true
class Content < ApplicationRecord
  include FriendlyId
  friendly_id :title, use: :slugged
  acts_as_taggable

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  private

  def should_generate_new_friendly_id?
    title_changed?
  end
end
