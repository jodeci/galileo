# frozen_string_literal: true
require "rails_helper"
require "vcr_helper"

RSpec.describe RssFeed::PlurkParser do
  let(:good_feed) do
    VCR.use_cassette("plurk_good_feed") do
      RssFeed::PlurkParser.new("jodeci")
    end
  end

  let(:bad_feed) do
    VCR.use_cassette("plurk_bad_feed") do
      RssFeed::PlurkParser.new("feed_not_found")
    end
  end

  describe "#plurks" do
    context "when the feed is available" do
      subject { good_feed.plurks }

      it "returns no more than 10 entries" do
        expect(subject.size).to be <= 10
      end

      describe "entry:link" do
        it { expect(subject.first[:link]).to match %r(^http://www.plurk.com/p/[\d\w]{6}) }
      end

      describe "entry:title" do
        it { expect(subject.first[:title]).to_not match %r(^jodeci ) }
      end
    end

    context "when the feed is private or does not exist" do
      it "returns an empty array" do
        expect(bad_feed.plurks).to eq []
      end
    end
  end
end
