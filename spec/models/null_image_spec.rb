# frozen_string_literal: true
require "rails_helper"

RSpec.describe NullImage, type: :model do
  describe ".file" do
    it { expect(NullImage.file).to eq NullImageFile }
  end

  describe ".asset_path" do
    it { expect(NullImage.asset_path("large")).to eq("/assets/no_image_large.png") }
  end

  describe ".large_url" do
    it { expect(NullImage.large_url).to eq("/assets/no_image_large.png") }
  end

  describe ".medium_url" do
    it { expect(NullImage.medium_url).to eq("/assets/no_image_medium.png") }
  end

  describe ".thumb_url" do
    it { expect(NullImage.thumb_url).to eq("/assets/no_image_thumb.png") }
  end
end

RSpec.describe NullImageFile, type: :model do
  describe ".url" do
    it { expect(NullImageFile.url("large")).to eq NullImage.asset_path("large") }
  end
end
