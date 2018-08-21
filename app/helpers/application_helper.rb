# frozen_string_literal: true
module ApplicationHelper
  def markdownify(content)
    HtmlPipeline::MarkdownRenderer.new(content).call
  end

  def foundation_icon(name)
    content_tag :i, nil, class: "fi-#{name}"
  end
end
