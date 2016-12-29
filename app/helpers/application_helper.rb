# frozen_string_literal: true
module ApplicationHelper
  def image_tag_l_by_id(id)
    image_tag find_image(id).large_url
  end

  def image_tag_m_by_id(id)
    image_tag find_image(id).medium_url
  end

  def image_tag_s_by_id(id)
    image_tag find_image(id).thumb_url
  end

  alias image_tag_by_id image_tag_m_by_id

  private

  def find_image(id)
    Image.fetch(id)
  end
end
