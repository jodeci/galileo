# frozen_string_literal: true
require "rss"
require "open-uri"
require_relative "plurk_entry"

module RssFeed
  class PlurkParser
    def initialize(user = Settings.feeds.plurk, limit = 10)
      @user = user
      @feed = "http://www.plurk.com/user/#{user}.xml"
      @entries = entries.take(limit)
    end

    def plurks
      result = []
      @entries.each do |entry|
        result << ::RssFeed::PlurkEntry.new(@user, entry).build_hash
      end
      result
    end

    private

    def entries
      open(@feed) { |rss| ::RSS::Parser.parse(rss).entries }
    rescue OpenURI::HTTPError
      []
    end
  end
end
