# frozen_string_literal: true
require "rails_helper"

RSpec.describe Image, type: :model do
  before do
    FactoryGirl.create(:image)
  end

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

  describe "#large_url" do
    it { expect(image.large_url).to eq "/uploads/image/file/1/large_test.jpg" }
  end

  describe "#medium_url" do
    it { expect(image.medium_url).to eq "/uploads/image/file/1/medium_test.jpg" }
  end

  describe "#thumb_url" do
    it { expect(image.thumb_url).to eq "/uploads/image/file/1/thumb_test.jpg" }
  end
end
