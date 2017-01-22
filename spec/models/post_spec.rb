# frozen_string_literal: true
require "rails_helper"

RSpec.describe Post, type: :model do
  let(:public_post) { FactoryGirl.create(:post, :public) }
  let(:protected_post) { FactoryGirl.create(:post, :protected) }
  let(:draft_post) { FactoryGirl.create(:post, :draft) }
  let(:featured_post) { FactoryGirl.create(:post, :public, featured: true) }
  subject { FactoryGirl.build(:post) }

  describe "validations" do
    context "for title" do
      it { should validate_presence_of(:title) }
    end

    context "for slug" do
      it { should validate_uniqueness_of(:slug).with_message(I18n.t("validation.uniqueness")) }
      it { should validate_presence_of(:slug) }

      context "when format is invalid" do
        it { should_not allow_value("中文").for(:slug).with_message(I18n.t("validation.format.slug")) }
        it { should_not allow_value("no spaces").for(:slug).with_message(I18n.t("validation.format.slug")) }
      end

      context "when format is valid" do
        it { should allow_value("This-is-okay_123").for(:slug) }
      end
    end

    context "for cover_image" do
      it { should validate_numericality_of(:cover_image) }
      it { should_not allow_value(-1).for(:cover_image) }
    end

    context "for featured" do
      it { should_not allow_value(true).for(:featured).with_message(I18n.t("validation.post.feature_only_public")) }

      context "public" do
        before { allow(subject).to receive(:status).and_return("public") }
        it { should allow_value(true).for(:featured).with_message(I18n.t("validation.post.feature_only_public")) }
      end
    end

    context "for published_at" do
      context "public" do
        before { allow(subject).to receive(:status).and_return("public") }
        it { should validate_presence_of(:published_at).with_message(I18n.t("validation.post.published_at_unless_draft")) }
      end

      context "protected" do
        before { allow(subject).to receive(:status).and_return("protected") }
        it { should validate_presence_of(:published_at).with_message(I18n.t("validation.post.published_at_unless_draft")) }
      end
    end
  end

  describe "#public?" do
    it { expect(public_post.public?).to be true }
    it { expect(protected_post.public?).to be false }
    it { expect(draft_post.public?).to be false }
  end

  describe "#protected?" do
    it { expect(protected_post.protected?).to be true }
    it { expect(public_post.protected?).to be false }
    it { expect(draft_post.protected?).to be false }
  end

  describe "#draft?" do
    it { expect(draft_post.draft?).to be true }
    it { expect(public_post.draft?).to be false }
    it { expect(protected_post.draft?).to be false }
  end

  describe ".published" do
    it { expect(Post.published).to include(public_post) }
    it { expect(Post.published).to include(protected_post) }
    it { expect(Post.published).not_to include(draft_post) }
  end

  describe ".featured" do
    it { expect(Post.featured).to include(featured_post) }
    it { expect(Post.featured).not_to include(public_post) }
  end
end
