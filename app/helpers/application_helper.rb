# frozen_string_literal: true
module ApplicationHelper
  def markdownify(content)
    HtmlPipeline::MarkdownRenderer.new(content).call
  end

  def exif_data(exif)
    return unless exif
    "#{exif[:date_time].strftime('%Y-%m-%d')} #{exif[:make]} #{exif[:model]} #{exif[:focal_length].to_i}mm f/#{exif[:f_number].to_f} #{exif[:exposure_time]} iso#{exif[:iso_speed_ratings]}"
  end

  def image_tag_by_id(*args, **options)
    image_tag Image.fetch_url(*args), options
  end

  def foundation_icon(name)
    content_tag :i, nil, class: "fi-#{name}"
  end
end
