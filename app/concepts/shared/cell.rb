# frozen_string_literal: true
module Shared::Cell
  def markdownify(content)
    HtmlPipeline::MarkdownRenderer.new(content).call
  end

  def image_tag_by_id(*args, **options)
    image_tag Image.fetch_url(*args), options
  end
end
