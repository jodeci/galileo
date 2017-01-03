# frozen_string_literal: true
class HtmlPipeline::MarkdownRenderer
  attr_reader :content

  def initialize(content)
    @content = content
    @whitelist = HTML::Pipeline::SanitizationFilter::WHITELIST
    @whitelist[:attributes][:all] << "class"
  end

  def call
    pipeline_context = { gfm: true, whitelist: @whitelist }
    pipeline = HTML::Pipeline.new [
      HtmlPipeline::MarkdownFilter,
      HtmlPipeline::ImageFilter,
      HtmlPipeline::EmojiFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::RougeFilter,
    ], pipeline_context
    # rubocop: disable OutputSafety
    pipeline.call(content)[:output].to_s.html_safe
  end
end
