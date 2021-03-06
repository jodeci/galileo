# frozen_string_literal: true
class HtmlPipeline::MarkdownRenderer
  attr_reader :content

  def initialize(content)
    @content = content
    @whitelist = HTML::Pipeline::SanitizationFilter::WHITELIST.deep_dup
    @whitelist[:attributes][:all] << "class"
  end

  def call
    # rubocop: disable OutputSafety
    pipeline.call(content)[:output].to_s.html_safe
    # rubocop: enable OutputSafety
  end

  private

  def pipeline
    HTML::Pipeline.new [
      Korgi::FileUploadFilter,
      Korgi::NamedRouteFilter,
      HtmlPipeline::MarkdownFilter,
      HtmlPipeline::EmojiFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::RougeFilter,
    ], context
  end

  def context
    { gfm: true, whitelist: @whitelist }
  end
end
