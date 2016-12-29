# frozen_string_literal: true
class Markdown::ImageFilter < HTML::Pipeline::Filter
  def call
    doc.search("img").each do |img|
      node = Markdown::ImageNode.new(img)
      img["src"] = node.image_url
      img["class"] = node.image_class
    end
    doc
  end
end
