# frozen_string_literal: true
require "rails_helper"

RSpec.describe Image, type: :model do
  before { FactoryGirl.create(:image) }
  let(:image) { Image.first }

  describe ".fetch" do
    context "when the image exists" do
      it "returns an Image object" do
        expect(Image.fetch(1)).to eq image
      end
    end

    context "when the image does not exist" do
      it "returns a NullImage object" do
        expect(Image.fetch(2)).to eq NullImage
      end
    end
  end

  describe ".fetch_url" do
    context "when not given the size" do
      it { expect(Image.fetch_url(1)).to eq "#{store_dir_prefix}/image/file/1/medium_test.jpg" }
    end

    context "when given a valid size" do
      it { expect(Image.fetch_url(1, "large")).to eq "#{store_dir_prefix}/image/file/1/large_test.jpg" }
      it { expect(Image.fetch_url(1, "medium")).to eq "#{store_dir_prefix}/image/file/1/medium_test.jpg" }
      it { expect(Image.fetch_url(1, "thumb")).to eq "#{store_dir_prefix}/image/file/1/thumb_test.jpg" }
    end

    context "when the given size does not exist" do
      it { expect(Image.fetch_url(1, "no_version")).to eq "#{store_dir_prefix}/image/file/1/medium_test.jpg" }
    end

    context "when the image does not exist" do
      it { expect(Image.fetch_url(0)).to eq "/assets/no_image_medium.png" }
    end
  end
end
