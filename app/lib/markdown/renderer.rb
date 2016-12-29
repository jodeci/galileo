# frozen_string_literal: true
class Markdown::Renderer
  attr_reader :content

  def initialize(content)
    @content = content
    @whitelist = HTML::Pipeline::SanitizationFilter::WHITELIST
    @whitelist[:attributes][:all] << "class"
  end

  def call
    pipeline_context = { gfm: true, whitelist: @whitelist }
    pipeline = HTML::Pipeline.new [
      Markdown::NoHtmlFilter,
      Markdown::ImageFilter,
      Markdown::EmojiFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::RougeFilter,
    ], pipeline_context
    # rubocop: disable OutputSafety
    pipeline.call(content)[:output].to_s.html_safe
  end
end
