# frozen_string_literal: true
class SimpleImageFilter < HTML::Pipeline::Filter
  def call
    doc.search("img").each do |img|
      next if (parse = parse_image_src(URI.decode(img["src"]))).nil?
      next if (image = Image.find_by(id: parse[:id])).nil?
      img["src"] = image_url(image, parse[:size])
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
      size: matches[2],
      klass: matches[3],
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
