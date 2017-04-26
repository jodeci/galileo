# frozen_string_literal: true
module Post::Cell
  class Base < Trailblazer::Cell
    include Shared::Cell
    extend ViewName::Flat

    property :title
    property :slug
    property :abstract
    property :body
    property :tag_list
    property :status
    property :published_at
    property :featured
    property :cover_image

    private

    def body_html
      return unless body
      markdownify(model.body)
    end

    def status
      I18n.t("jurou.post.status.#{model.status}")
    end

    def published_date
      return unless published_at
      model.published_at.strftime("%Y-%m-%d")
    end

    def featured
      I18n.t(model.featured.to_s)
    end

    def cover_image_tag
      return unless cover_image
      image_tag_by_id(model.cover_image)
    end

    def statuses
      model.model.class.statuses.keys.map do |key|
        [I18n.t("jurou.post.status.#{key}"), key]
      end
    end
  end
end
