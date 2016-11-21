# frozen_string_literal: true
require "rails_helper"

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.create(:post) }

  describe "validations" do
    context "for slug" do
      subject { FactoryGirl.build(:post) }
      it { should validate_uniqueness_of(:slug).with_message(I18n.t("validation.uniqueness")) }

      context "when format is invalid" do
        it { should_not allow_value("中文").for(:slug).with_message(I18n.t("validation.format.slug")) }
        it { should_not allow_value("no spaces").for(:slug).with_message(I18n.t("validation.format.slug")) }
      end

      context "when format is valid" do
        it { should allow_value("This-is-okay_123").for(:slug) }
      end
    end
  end
end
