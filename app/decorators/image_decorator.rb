# frozen_string_literal: true
module ImageDecorator
  def resized(size)
    image_tag ImageVariant.new(file).send(size)
  end

  def exif_data
    return unless file.metadata.dig(:exif)
    "#{Time.parse(file.metadata[:exif][:date_time]).strftime('%Y-%m-%d')} #{file.metadata[:exif][:make]} #{file.metadata[:exif][:model]} #{file.metadata[:exif][:focal_length].to_i}mm f/#{file.metadata[:exif][:f_number].to_f} #{file.metadata[:exif][:exposure_time]} iso#{file.metadata[:exif][:iso_speed_ratings]}"
  end
end
