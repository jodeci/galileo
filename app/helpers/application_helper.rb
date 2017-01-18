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

  def foundation_icon(name)
    content_tag :i, nil, class: "fi-#{name}"
  end

  def taglist_with_icons(tags)
    return unless tags.any?
    content_tag :div, nil, class: "tags" do
      tag_with_icon(tags)
    end
  end

  private

  def tag_with_icon(tags)
    tags.map do |tag|
      concat foundation_icon("price-tag")
      concat link_to tag, posts_taglist_path(tag)
    end
  end
end
