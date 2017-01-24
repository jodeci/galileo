# frozen_string_literal: true
require "rss"
require "open-uri"
require_relative "flickr_item"

module RssFeed
  class FlickrParser
    def initialize(user = Settings.feeds.flickr, limit = 4)
      @user = user
      @feed = "https://www.flickr.com/services/feeds/photos_public.gne?id=#{user}&lang=en-us&format=rss"
      @items = items.take(limit)
    end

    def photos
      result = []
      @items.each do |item|
        result << ::RssFeed::FlickrItem.new(item).build_hash
      end
      result
    end

    private

    def items
      open(@feed) { |rss| RSS::Parser.parse(rss).items }
    rescue OpenURI::HTTPError
      []
    end
  end
end
