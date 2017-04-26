# frozen_string_literal: true
module Post::Contract
  class Base < Reform::Form
    property :title
    property :slug
    property :body
    property :abstract
    property :cover_image
    property :status
    property :published_at
    property :featured
    property :tag_list

    validates :title, presence: true
    validates :slug, presence: { message: "BAD, need slug" }
  end
end
