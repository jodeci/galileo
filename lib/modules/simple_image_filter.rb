# frozen_string_literal: true
class SimpleImageFilter < HTML::Pipeline::Filter
  include ApplicationHelper

  def call
    doc.search("img").each do |img|
      next if (parse = parse_image_src(URI.decode(img["src"]))).nil?
      next if (image = Image.find_by(id: parse[:id])).nil?
      img["src"] = image.file.url(parse[:size])
      img["class"] = parse[:klass] unless parse[:klass].nil?
    end
    doc
  end

  private

  def parse_image_src(link)
    matches = link.match(/^([\w\d\.]+)(?:\|(\w*))?(?:\|([\w\s\d]+))?$/)
    return if matches.blank?
    {
      id: matches[1],
      size: image_size(matches[2]),
      klass: matches[3],
    }
  end
end
