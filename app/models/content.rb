# frozen_string_literal: true
class Content < ApplicationRecord
  include FriendlyId
  friendly_id :slug, use: :slugged
  acts_as_taggable
end
