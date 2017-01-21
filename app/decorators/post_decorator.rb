# frozen_string_literal: true
module PostDecorator
  def published_date
    return unless published_at
    published_at.strftime("%Y-%m-%d")
  end

  def status_translated
    jr_value :status, status, :post
  end

  def cover_image_tag
    return unless cover_image
    image_tag_by_id(cover_image)
  end
end
