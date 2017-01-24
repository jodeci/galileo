# frozen_string_literal: true
require "rails_helper"
require "vcr_helper"

RSpec.describe RssFeed::FlickrParser do
  let(:good_feed) do
    VCR.use_cassette("flickr_good_feed") do
      RssFeed::FlickrParser.new("31128754@N00")
    end
  end

  let(:bad_feed) do
    VCR.use_cassette("flickr_bad_feed") do
      RssFeed::FlickrParser.new("feed_not_found")
    end
  end

  describe "#photos" do
    context "when the feed is available" do
      subject { good_feed.photos }

      it "returns no more than 4 entries" do
        expect(subject.size).to be <= 4
      end

      describe "entry:link" do
        it { expect(subject.first[:link]).to match %r{^https://www.flickr.com/photos/31128754@N00/[\d]{10}/$} }
      end

      describe "entry:src" do
        it { expect(subject.first[:src]).to match %r{staticflickr.com} }
      end
    end

    context "when the feed is private or does not exist" do
      it "returns an empty array" do
        expect(bad_feed.photos).to eq []
      end
    end
  end
end
