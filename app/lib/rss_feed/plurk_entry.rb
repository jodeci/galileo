# frozen_string_literal: true
require "rss"

module RssFeed
  class PlurkEntry
    def initialize(user, plurk)
      @user = user
      @link = plurk.link.href
      @title = plurk.title.content
    end

    def build_hash
      { link: build_link, title: build_title }
    end

    private

    def build_link
      @link.gsub!("user/#{@user}.xml/", "")
    end

    def build_title
      @title.gsub!("#{@user} ", "")
    end
  end
end
