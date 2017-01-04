# frozen_string_literal: true
require "rails_helper"

RSpec.describe HtmlPipeline::ImageMeta do
  subject { HtmlPipeline::ImageMeta.new(src) }

  describe "#image_id" do
    let(:src) { "1" }
    it "returns the image id" do
      expect(subject.image_id).to eq "1"
    end
  end

  describe "#image_size" do
    context "src: 1" do
      let(:src) { "1" }
      it { expect(subject.image_size).to eq "large" }
    end

    context "src: 1|l" do
      let(:src) { "1|l" }
      it { expect(subject.image_size).to eq "large" }
    end

    context "src: 1|large" do
      let(:src) { "1|large" }
      it { expect(subject.image_size).to eq "large" }
    end

    context "src: 1|m" do
      let(:src) { "1|m" }
      it { expect(subject.image_size).to eq "medium" }
    end

    context "src: 1|medium" do
      let(:src) { "1|medium" }
      it { expect(subject.image_size).to eq "medium" }
    end

    context "src: 1|s" do
      let(:src) { "1|s" }
      it { expect(subject.image_size).to eq "thumb" }
    end

    context "src: 1|small" do
      let(:src) { "1|small" }
      it { expect(subject.image_size).to eq "thumb" }
    end

    context "src: 1|thumb" do
      let(:src) { "1|thumb" }
      it { expect(subject.image_size).to eq "thumb" }
    end
  end

  describe "#image_class" do
    context "src: 1||my_class" do
      let(:src) { "1||my_class" }
      it { expect(subject.image_class).to eq "my_class" }
    end

    context "src: 1" do
      let(:src) { "1" }
      it { expect(subject.image_class).to eq nil }
    end
  end
end
