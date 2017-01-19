# frozen_string_literal: true
require "rails_helper"

RSpec.describe Post, type: :model do
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
  end
end
