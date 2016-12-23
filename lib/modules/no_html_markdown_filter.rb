# frozen_string_literal: true
class NoHtmlMarkdownFilter < HTML::Pipeline::MarkdownFilter
  def call
    while @text.index(unique = SecureRandom.hex); end
    @text.gsub!("<", "#{unique} ")
    super.gsub(Regexp.new("#{unique}\\s?"), "&lt;")
  end
end
