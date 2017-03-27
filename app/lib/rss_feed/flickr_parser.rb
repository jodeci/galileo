# frozen_string_literal: true
require "rss"
require "open-uri"
require_relative "flickr_item"

module RssFeed
  class FlickrParser
    attr_reader :feed, :items

    def initialize(user = Settings.feeds.flickr, limit = 4)
      @feed = "https://www.flickr.com/services/feeds/photos_public.gne?id=#{user}&lang=en-us&format=rss"
      @items = parsed_items.take(limit)
    end

    def photos
      items.reduce([]) do |result, item|
        result << ::RssFeed::FlickrItem.new(item).build_hash
      end
    end

    private

    def parsed_items
      open(feed) { |rss| RSS::Parser.parse(rss).items }
    rescue OpenURI::HTTPError
      []
    end
  end
end
