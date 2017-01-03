# frozen_string_literal: true
class HtmlPipeline::ImageFilter < HTML::Pipeline::Filter
  def call
    doc.search("img").each do |img|
      node = HtmlPipeline::ImageNode.new(img)
      node.replace_image
    end
    doc
  end
end
