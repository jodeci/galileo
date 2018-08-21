# frozen_string_literal: false
require "rails_helper"

describe ApplicationHelper, type: :helper do
  # before { FactoryBot.create(:image) }
  let(:image) { Image.first }

  describe "#markdownify" do
    it { expect(markdownify("test")).to eq "<p>test</p>" }
  end

  describe "#exif_data" do
    pending { expect(exif_data(image.exif)).to eq "2016-09-28 FUJIFILM FinePix X100 23mm f/4.0 1/125 iso400" }
  end

  describe "#foundation_icon" do
    it { expect(foundation_icon("paw")).to eq %(<i class="fi-paw"></i>) }
  end
end
