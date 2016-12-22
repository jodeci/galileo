# frozen_string_literal: true
module HtmlPipelineHelper
  def markdownify(content)
    pipeline_context = { gfm: true, whitelist: sanitize_whitelist }
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SimpleImageFilter,
      HTML::Pipeline::SanitizationFilter
    ], pipeline_context
    pipeline.call(content)[:output].to_s.html_safe
  end

  private

  def sanitize_whitelist
    list = HTML::Pipeline::SanitizationFilter::WHITELIST
    list[:attributes][:all] << "class"
    list
  end
end

class SimpleImageFilter < HTML::Pipeline::Filter
  def call
    doc.search("img").each do |img|
      next if (parse = parse_media_link(URI.decode(img["src"]))).nil?
      image = Image.find(parse[:id])
      img["src"] = image_url(image, parse[:size])
      img["class"] = parse[:klass] unless parse[:klass].nil?
    end
    doc
  end

  private

  def parse_media_link(link)
    matches = link.match(/^([\w\d\.]+)(?:\|(\w*))?(?:\|([\w\s\d]+))?$/)
    return if matches.blank?
    {
      id: matches[1],
      size: matches[2],
      klass: matches[3]
    }
  end

  def image_url(image, size)
    case size
    when "medium" then image.file.medium.url
    when "thumb" then image.file.thumb.url
    else
      image.file.large.url
    end
  end
end
