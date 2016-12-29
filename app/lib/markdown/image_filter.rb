# frozen_string_literal: true
class Markdown::ImageFilter < HTML::Pipeline::Filter
  def call
    doc.search("img").each do |img|
      node = Markdown::ImageNode.new(img)
      node.replace_image
    end
    doc
  end
end
