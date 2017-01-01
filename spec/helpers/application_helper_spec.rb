# frozen_string_literal: false
require "rails_helper"

describe ApplicationHelper, type: :helper do
  before { FactoryGirl.create(:image) }
  let(:image) { Image.first }

  describe "#markdownify" do
    it { expect(markdownify("test")).to eq "<p>test</p>" }
  end

  describe "#exif_data" do
    it { expect(exif_data(image.exif)).to eq "2016-09-28 FUJIFILM FinePix X100 23mm f/4.0 1/125 iso400" }
  end

  describe "#image_tag_l_by_id" do
    it { expect(image_tag_l_by_id(1)).to eq '<img src="/uploads/image/file/1/large_test.jpg" alt="Large test" />' }
  end

  describe "#image_tag_m_by_id" do
    it { expect(image_tag_m_by_id(1)).to eq '<img src="/uploads/image/file/1/medium_test.jpg" alt="Medium test" />' }
  end

  describe "#image_tag_s_by_id" do
    it { expect(image_tag_s_by_id(1)).to eq '<img src="/uploads/image/file/1/thumb_test.jpg" alt="Thumb test" />' }
  end
end
