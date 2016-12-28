# frozen_string_literal: true
class SimpleImageFilter < HTML::Pipeline::Filter
  def call
    doc.search("img").each do |img|
      node = ImageNode.new(img)
      img["src"] = node.src
      img["class"] = node.klass
    end
    doc
  end
end
