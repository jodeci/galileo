# frozen_string_literal: true
class Markdown::ImageNode
  attr_reader :image_url, :image_class

  def initialize(node)
    @meta = Markdown::ImageMeta.new(node["src"])
    @image = find_image
  end

  def find_image
    Image.find_by(id: @meta.image_id)
  end

  def image_url
    @image.file.url(@meta.image_size)
  end

  def image_class
    @meta.image_class
  end
end
