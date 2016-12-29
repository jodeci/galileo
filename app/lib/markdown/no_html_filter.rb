# frozen_string_literal: true
class Markdown::NoHtmlFilter < HTML::Pipeline::MarkdownFilter
  def initialize(text, context = nil, result = nil)
    super text, context, result
    @text = text
  end

  def call
    while @text.index(unique = SecureRandom.hex); end
    @text.gsub!("<", "#{unique} ")
    super.gsub(Regexp.new("#{unique}\\s?"), "&lt;")
  end
end
