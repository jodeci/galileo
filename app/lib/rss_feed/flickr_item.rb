# frozen_string_literal: true
require "rss"
require "nokogiri"

module RssFeed
  class FlickrItem
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def build_hash
      { link: build_link, src: build_src }
    end

    private

    def build_src
      Nokogiri::HTML(item.description).xpath("//img").attr("src").to_s
    end

    def build_link
      item.link
    end
  end
end
