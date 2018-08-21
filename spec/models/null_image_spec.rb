# frozen_string_literal: true
require "rails_helper"

RSpec.describe NullImage, type: :model do
  describe ".file" do
    it { expect(NullImage.file).to eq NullImageFile }
  end

  describe ".asset_path" do
    it { expect(NullImage.asset_path("large")).to eq("/assets/no_image_large.png") }
  end
end

RSpec.describe NullImageFile, type: :model do
  describe "variants" do
    it { expect(NullImageFile.large).to eq NullImage.asset_path("large") }
    it { expect(NullImageFile.medium).to eq NullImage.asset_path("medium") }
    it { expect(NullImageFile.thumb).to eq NullImage.asset_path("thumb") }
  end
end
