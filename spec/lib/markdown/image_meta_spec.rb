# frozen_string_literal: true
require "rails_helper"

RSpec.describe Markdown::ImageMeta do
  describe "#image_id" do
    it "returns the image id" do
      expect(Markdown::ImageMeta.new("1").image_id).to eq "1"
    end
  end

  describe "#image_size" do
    context "when specified size" do
      it "matches l, large to large" do
        expect(Markdown::ImageMeta.new("1|l").image_size).to eq "large"
        expect(Markdown::ImageMeta.new("1|large").image_size).to eq "large"
      end

      it "matches m, medium to medium" do
        expect(Markdown::ImageMeta.new("1|m").image_size).to eq "medium"
        expect(Markdown::ImageMeta.new("1|medium").image_size).to eq "medium"
      end

      it "matches s, small, thumb to thumb" do
        expect(Markdown::ImageMeta.new("1|s").image_size).to eq "thumb"
        expect(Markdown::ImageMeta.new("1|small").image_size).to eq "thumb"
        expect(Markdown::ImageMeta.new("1|thumb").image_size).to eq "thumb"
      end
    end

    context "when size is not given" do
      it "returns the default image size (large)" do
        expect(Markdown::ImageMeta.new("1||my_class").image_size).to eq "large"
      end
    end
  end

  describe "#image_class" do
    context "when specified class" do
      it "returns the image class" do
        expect(Markdown::ImageMeta.new("1|l|my_class").image_class).to eq "my_class"
      end
    end

    context "when class is not given" do
      it "returns nil" do
        expect(Markdown::ImageMeta.new("1|s").image_class).to eq nil
      end
    end
  end
end
