# frozen_string_literal: true
require "rails_helper"

RSpec.describe Post, type: :model do
  let(:published_post) { FactoryGirl.create(:post, :published) }
  let(:password_protected_post) { FactoryGirl.create(:post, :password_protected) }
  let(:draft_post) { FactoryGirl.create(:post, :draft) }
  let(:featured_post) { FactoryGirl.create(:post, :published, featured: true) }
  subject { FactoryGirl.build(:post) }

  describe "validations" do
    context ":title" do
      it { should validate_presence_of(:title) }
    end

    context ":slug" do
      it { should validate_uniqueness_of(:slug).with_message(I18n.t("validation.uniqueness")) }
      it { should validate_presence_of(:slug) }

      context "when format is invalid" do
        it { should_not allow_values("中文", "no spaces").for(:slug).with_message(I18n.t("validation.format.slug")) }
      end

      context "when format is valid" do
        it { should allow_value("This-is-okay_123").for(:slug) }
      end
    end

    context ":cover_image" do
      it { should validate_numericality_of(:cover_image) }
      it { should_not allow_value(-1).for(:cover_image) }
    end

    context ":featured" do
      context "when published" do
        before { allow(subject).to receive(:published?).and_return(true) }
        it { should allow_value(true).for(:featured).with_message(I18n.t("validation.post.featured")) }
      end

      context "when not published" do
        before { allow(subject).to receive(:published?).and_return(false) }
        it { should_not allow_value(true).for(:featured).with_message(I18n.t("validation.post.featured")) }
      end
    end

    context ":published_at" do
      before { allow(subject).to receive(:draft?).and_return(false) }
      it { should validate_presence_of(:published_at).with_message(I18n.t("validation.post.published_at")) }
    end
  end

  describe ".listed" do
    it { expect(Post.listed).to include(published_post) }
    it { expect(Post.listed).to include(password_protected_post) }
    it { expect(Post.listed).not_to include(draft_post) }
  end

  describe ".featured" do
    it { expect(Post.featured).to include(featured_post) }
    it { expect(Post.featured).not_to include(published_post) }
  end
end
