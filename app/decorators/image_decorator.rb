# frozen_string_literal: true
module ImageDecorator
  def resized(size)
    image_tag ImageVariant.new(file).send(size)
  end

  def exif_data
    return unless file.metadata.dig(:exif)
    [date_time, camera, focal_length, f_number, iso].join(" ")
  end

  private

  def date_time
    Date.parse(file.metadata[:exif][:date_time]).strftime("%Y-%m-%d")
  end

  def camera
    "#{file.metadata[:exif][:make]} #{file.metadata[:exif][:model]}"
  end

  def focal_length
    "#{file.metadata[:exif][:focal_length].to_i}mm"
  end

  def f_number
    "f/#{file.metadata[:exif][:f_number].to_f}"
  end

  def iso
    "iso#{file.metadata[:exif][:iso_speed_ratings]}"
  end
end
