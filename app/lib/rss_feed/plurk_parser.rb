# frozen_string_literal: true
require "rss"
require "open-uri"
require_relative "plurk_entry"

module RssFeed
  class PlurkParser
    attr_reader :user, :feed, :entries

    def initialize(user = Settings.feeds.plurk, limit = 10)
      @user = user
      @feed = URI.parse("http://www.plurk.com/user/#{user}.xml")
      @entries = parsed_entries.take(limit)
    end

    def plurks
      entries.reduce([]) do |result, entry|
        result << ::RssFeed::PlurkEntry.new(user, entry).build_hash
      end
    end

    private

    def parsed_entries
      feed.open { |rss| RSS::Parser.parse(rss).entries }
    rescue OpenURI::HTTPError
      []
    end
  end
end
