# frozen_string_literal: true
module ApplicationHelper
  def markdownify(content)
    RenderMarkdown.new(content).call.html_safe
  end

  def exif_data(data = {})
    return if data.blank?
    "#{data[:date_time].strftime('%Y-%m-%d')} #{data[:make]} #{data[:model]} #{data[:focal_length].to_i}mm f/#{data[:f_number].to_f} #{data[:exposure_time]} iso#{data[:iso_speed_ratings]}"
  end

  def image_tag_by_id(id, size = "medium")
    return if (image = Image.find_by(id: id)).nil?
    image_tag image.file.url(image_size(size))
  end

  private

  def image_size(size)
    case size
    when "large", "l" then "large"
    when "medium", "m" then "medium"
    when "thumb", "small", "s" then "thumb"
    else
      "large"
    end
  end
end
