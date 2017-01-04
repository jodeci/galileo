# frozen_string_literal: true
require "rails_helper"

RSpec.describe HtmlPipeline::ImageNode do
  before { FactoryGirl.create(:image) }
  let(:image) { Image.first }

  subject do
    node = Nokogiri::XML::Node.new("img", Nokogiri::HTML::Document.new)
    node["src"] = src
    HtmlPipeline::ImageNode.new(node)
  end

  describe "#replace_image" do
    before(:each) { @image_node = subject.replace_image }

    context "src: 1" do
      let(:src) { "1" }
      it "replaces image_id with the default image url (large)" do
        expect(@image_node["src"]).to eq "/spec/support/uploads/image/file/1/large_test.jpg"
      end
    end

    context "src: 1|s" do
      let(:src) { "1|s" }
      it "replaces image_id with the respective image url" do
        expect(@image_node["src"]).to eq "/spec/support/uploads/image/file/1/thumb_test.jpg"
      end
    end

    context "src: 1||my_class" do
      let(:src) { "1||my_class" }
      it "adds the given css class to the node" do
        expect(@image_node["class"]).to eq "my_class"
      end
    end

    context "src: 0" do
      let(:src) { "0" }
      it "replaces image_id with the default NullImage url (large)" do
        expect(@image_node["src"]).to eq("/assets/no_image_large.png")
      end
    end

    context "src: 0||ignored" do
      let(:src) { "0||ignored" }
      it "adds .no_image to the node" do
        expect(@image_node["class"]).to eq "no_image"
      end
    end

    context "src: 0|s" do
      let(:src) { "0|s" }
      it "replaces image_id with the respective NullImage url" do
        expect(@image_node["src"]).to eq("/assets/no_image_thumb.png")
      end
    end
  end
end
