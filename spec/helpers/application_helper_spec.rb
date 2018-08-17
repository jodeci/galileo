# frozen_string_literal: false
require "rails_helper"

describe ApplicationHelper, type: :helper do
  before { FactoryBot.create(:image) }
  let(:image) { Image.first }

  describe "#markdownify" do
    it { expect(markdownify("test")).to eq "<p>test</p>" }
  end

  describe "#exif_data" do
    it { expect(exif_data(image.exif)).to eq "2016-09-28 FUJIFILM FinePix X100 23mm f/4.0 1/125 iso400" }
  end

  describe "#image_tag_by_id" do
    it { expect(image_tag_by_id(0)).to eq %(<img src="/assets/no_image_medium.png" />) }
    it { expect(image_tag_by_id(1, class: "myclass")).to eq %(<img class="myclass" src="#{store_dir_prefix}/image/file/1/medium_test.jpg" />) }
  end

  describe "#foundation_icon" do
    it { expect(foundation_icon("paw")).to eq %(<i class="fi-paw"></i>) }
  end
end
