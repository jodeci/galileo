# frozen_string_literal: true
module RedcarpetHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(
      HTMLBlockCode,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      autolink: true,
      tables: true,
      underline: true,
      highlight: true
    )
    markdown.render(text).html_safe
  end
end

class HTMLBlockCode < Redcarpet::Render::HTML
  include Sprockets::Rails::Helper
  include ActionView::Helpers::UrlHelper

  def parse_media_link(link)
    matches = link.match(/^([\w\d\.]+)(?:\|(\w+))?(?:\|([\w\s\d]+))?$/)
    return if matches.blank?
    {
      id: matches[1],
      size: matches[2],
      class: matches[3]
    }
  end

  def image(link, title, alt_text)
    klass = nil

    if nil != (parse = parse_media_link(link))
      media = Image.find(parse[:id])
      if media
        link = image_url(media, parse[:size])
        klass = parse[:class]
      end
    end

    image_tag(link, title: title, alt: alt_text, class: klass)
  end

  def link(link, title, content)
    klass = nil

    if nil != (parse = parse_media_link(link))
      media = Image.find(parse[:id])
      if media
        link = image_url(media, parse[:size])
        klass = parse[:class]
      end
    end

    link_to(content, link, title: title, class: klass)
  end

  def image_url(image, size)
    case size
    when "medium" then image.info.medium.url
    when "thumb" then image.info.thumb.url
    else
      image.info.large.url
    end
  end
end
