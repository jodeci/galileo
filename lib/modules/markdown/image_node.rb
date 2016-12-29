# frozen_string_literal: true
class Markdown::ImageNode
  def initialize(node)
    @node = node
    @meta = Markdown::ImageMeta.new(node["src"])
    @image = find_image
  end

  def replace_image
    @node["src"] = image_url
    @node["class"] = image_class if image_class
    @node
  end

  def image_class
    if @image == NullImage
      "no_image"
    else
      @meta.image_class
    end
  end

  def find_image
    Image.find_by(id: @meta.image_id) || NullImage
  end

  def image_url
    @image.file.url(@meta.image_size)
  rescue
    NullImage.path
  end
end
