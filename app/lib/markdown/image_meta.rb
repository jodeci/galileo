# frozen_string_literal: true
class Markdown::ImageMeta
  attr_reader :image_id, :image_size, :image_class

  def initialize(src)
    @src = src
    @image = parse_image
  end

  def image_id
    @image[1]
  end

  def image_size
    case @image[2]
    when "l", "large" then "large"
    when "m", "medium" then "medium"
    when "s", "small", "thumb" then "thumb"
    else
      "large"
    end
  end

  def image_class
    @image[3]
  end

  private

  def parse_image
    URI.unescape(@src).match(/^([\w\d\.]+)(?:\|(\w*))?(?:\|([\w\s\d]+))?$/)
  end
end
