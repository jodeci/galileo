# frozen_string_literal: true
class ImageNode
  attr_reader :src, :klass

  def initialize(node)
    @node = node
    @meta = ImageMeta.new(node["src"])
    @image = find_image
  end

  def find_image
    Image.find_by(id: @meta.image_id)
  end

  def src
    @image.file.url(@meta.image_size)
  end

  def klass
    @meta.image_class
  end
end
