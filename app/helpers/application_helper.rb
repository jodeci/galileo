# frozen_string_literal: true
module ApplicationHelper
  def exif_data(data = {})
    return if data.blank?
    "#{data[:date_time].strftime('%Y-%m-%d')} #{data[:make]} #{data[:model]} #{data[:focal_length].to_i}mm f/#{data[:f_number].to_f} #{data[:exposure_time]} iso#{data[:iso_speed_ratings]}"
  end
end
