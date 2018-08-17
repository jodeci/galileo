# frozen_string_literal: true
require "rails_helper"

RSpec.describe Image, type: :model do
  before { FactoryBot.create(:image) }
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
end
