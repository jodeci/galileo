# frozen_string_literal: true
require "rails_helper"

describe PostDecorator, type: :decorator do
  let(:published_post) { FactoryBot.create(:post, :published, :abstract) }
  let(:draft_post) { FactoryBot.create(:post, :draft) }
  let(:decorated_published) { ActiveDecorator::Decorator.instance.decorate(published_post) }
  let(:decorated_draft) { ActiveDecorator::Decorator.instance.decorate(draft_post) }

  describe "#published_date" do
    it { expect(decorated_published.published_date).to eq "2014-03-18" }
    it { expect(decorated_draft.published_date).to eq nil }
  end

  describe "#status_translated" do
    it { expect(decorated_published.status_translated).to eq "公開" }
  end

  describe "#abstract_text" do
    it { expect(decorated_published.abstract_text).to eq "abstract text" }
    it { expect(decorated_draft.abstract_text).to eq I18n.t("misc.default_abstract") }
  end

  describe "#description" do
    it { expect(decorated_published.description).to eq "abstract text" }
    it { expect(decorated_draft.description).to eq I18n.t("misc.default_description") }
  end

  describe "#open_graph" do
    it { expect(decorated_draft.open_graph).to include(:title, :description, :url, :image) }
  end
end
