# frozen_string_literal: true
require "rails_helper"

# create images separately to avoid thread exception from minimagick
RSpec.describe Image, type: :model do
  describe ".fetch" do
    context "when the image exists" do
      it "returns an Image object" do
        FactoryBot.create(:image)
        expect(Image.fetch(1)).to eq Image.first
      end
    end

    context "when the image does not exist" do
      it "returns a NullImage object" do
        expect(Image.fetch(1)).to eq NullImage
      end
    end
  end

  it "should contain exif data" do
    image = FactoryBot.create(:image)
    image.file.attach(create_file_blob)
    expect(image.file.metadata).to include(:exif)
  end
end
