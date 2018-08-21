# frozen_string_literal: true
require "exifr/jpeg"

module ActiveStorage
  class Analyzer::ImageAnalyzer < Analyzer
    def metadata
      read_image do |image|
        if rotated_image?(image)
          { width: image.height, height: image.width }
        else
          { width: image.width, height: image.height }
        end.merge(exifdata(image) || {})
      end
    rescue LoadError
      logger.info "Skipping image analysis because the mini_magick gem isn't installed"
      {}
    end

    private

    def exifdata(image)
      return unless image.type == "JPEG"
      reader = EXIFR::JPEG.new(image.path)
      { exif: reader.to_hash } if reader.exif?
    rescue EXIFR::MalformedImage, EXIFR::MalformedJPEG
    end
  end
end
