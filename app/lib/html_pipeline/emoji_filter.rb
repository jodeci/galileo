# frozen_string_literal: true
class HtmlPipeline::EmojiFilter < HTML::Pipeline::Filter
  def call
    Twemoji.parse(doc, options)
  end

  private

  def options
    {
      file_ext: context[:file_ext] || "svg",
      class_name: context[:class_name] || "emoji",
      img_attrs:  context[:img_attrs] || {},
    }
  end
end
