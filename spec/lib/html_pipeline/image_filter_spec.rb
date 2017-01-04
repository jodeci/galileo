# frozen_string_literal: true
require "rails_helper"

RSpec.describe HtmlPipeline::ImageFilter do
  before { FactoryGirl.create(:image) }

  subject do
    filter = HtmlPipeline::ImageFilter.new(doc)
    filter.call.to_s
  end

  context "src: 1|s" do
    let(:doc) { '<img src="1|s">' }
    it { expect(subject).to eq '<img src="/spec/support/uploads/image/file/1/thumb_test.jpg">' }
  end

  context "src: 1||my_class" do
    let(:doc) { '<img src="1||my_class">' }
    it { expect(subject).to eq '<img src="/spec/support/uploads/image/file/1/large_test.jpg" class="my_class">' }
  end

  context "src: 1|m|my_class" do
    let(:doc) { '<img src="1|m|my_class">' }
    it { expect(subject).to eq '<img src="/spec/support/uploads/image/file/1/medium_test.jpg" class="my_class">' }
  end

  context "src: 0" do
    let(:doc) { '<img src="0">' }
    it { expect(subject).to eq '<img src="/assets/no_image_large.png" class="no_image">' }
  end

  context "src: 0|s" do
    let(:doc) { '<img src="0|s">' }
    it { expect(subject).to eq '<img src="/assets/no_image_thumb.png" class="no_image">' }
  end
end
