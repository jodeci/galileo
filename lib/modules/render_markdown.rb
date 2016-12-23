# frozen_string_literal: true
class RenderMarkdown
  attr_reader :content

  def initialize(content)
    @content = content
  end

  def call
    pipeline_context = { gfm: true, whitelist: sanitize_whitelist }
    pipeline = HTML::Pipeline.new [
      NoHtmlMarkdownFilter,
      EmojiFilter,
      SimpleImageFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::RougeFilter,
    ], pipeline_context
    pipeline.call(content)[:output].to_s
  end

  private

  def sanitize_whitelist
    list = HTML::Pipeline::SanitizationFilter::WHITELIST
    list[:attributes][:all] << "class"
    list
  end
end
