# frozen_string_literal: true
class Markdown::ImageNode
  def initialize(node)
    @node = node
    @meta = Markdown::ImageMeta.new(node["src"])
    @image = Image.fetch(@meta.image_id)
  end

  def replace_image
    @node["src"] = @image.file.url(@meta.image_size)
    @node["class"] = image_class if image_class
    @node
  end

  private

  def image_class
    if @image == NullImage
      "no_image"
    else
      @meta.image_class
    end
  end
end
