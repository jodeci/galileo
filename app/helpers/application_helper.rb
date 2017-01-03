# frozen_string_literal: true
module ApplicationHelper
  def markdownify(content)
    HtmlPipeline::MarkdownRenderer.new(content).call
  end

  def exif_data(exif)
    return unless exif
    "#{exif[:date_time].strftime('%Y-%m-%d')} #{exif[:make]} #{exif[:model]} #{exif[:focal_length].to_i}mm f/#{exif[:f_number].to_f} #{exif[:exposure_time]} iso#{exif[:iso_speed_ratings]}"
  end

  def image_tag_l_by_id(id)
    image_tag Image.fetch(id).large_url
  end

  def image_tag_m_by_id(id)
    image_tag Image.fetch(id).medium_url
  end

  def image_tag_s_by_id(id)
    image_tag Image.fetch(id).thumb_url
  end

  alias image_tag_by_id image_tag_m_by_id
end
