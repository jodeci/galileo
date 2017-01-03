# frozen_string_literal: true
require "rails_helper"

RSpec.describe Markdown::ImageNode do
  before { FactoryGirl.create(:image) }
  let(:image) { Image.first }
  let(:node) { Nokogiri::XML::Node.new("img", Nokogiri::HTML::Document.new) }

  describe "#replace_image" do
    context "with an Image object" do
      context "when size is not specified" do
        it "replaces image_id with the default image url (large)" do
          node["src"] = image.id
          image_node = Markdown::ImageNode.new(node).replace_image
          expect(image_node["src"]).to eq "/spec/support/uploads/image/file/1/large_test.jpg"
        end
      end

      context "when size is specified" do
        it "replaces image_id with the relevant image url" do
          node["src"] = "#{image.id}|s"
          image_node = Markdown::ImageNode.new(node).replace_image
          expect(image_node["src"]).to eq "/spec/support/uploads/image/file/1/thumb_test.jpg"
        end
      end

      context "when class is specified" do
        it "adds the given css class to the node" do
          node["src"] = "#{image.id}||my_class"
          image_node = Markdown::ImageNode.new(node).replace_image
          expect(image_node["class"]).to eq "my_class"
        end
      end
    end

    context "with a NullImage object" do
      before { node["src"] = "0||ignored" }
      let(:image_node) { Markdown::ImageNode.new(node).replace_image }

      it "adds .no_image to the node" do
        expect(image_node["class"]).to eq "no_image"
      end

      context "when size is not specified" do
        it "replaces image_id with the default image url (large)" do
          expect(image_node["src"]).to eq("/assets/no_image_large.png")
        end
      end

      context "when size is specified" do
        it "replaces image_id with the relevant image url" do
          node["src"] = "0|s"
          image_node = Markdown::ImageNode.new(node).replace_image
          expect(image_node["src"]).to eq("/assets/no_image_thumb.png")
        end
      end
    end
  end
end
