# frozen_string_literal: true
require "rails_helper"

describe PostDecorator, type: :decorator do
  before { FactoryBot.create(:image) }
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

  describe "#cover_image_url" do
    it { expect(decorated_published.cover_image_url).to eq "http://test.host#{store_dir_prefix}/image/file/1/medium_test.jpg" }
    it { expect(decorated_draft.cover_image_url).to eq "http://test.host/assets/cover.jpg" }
  end

  describe "#open_graph" do
    it { expect(decorated_published.open_graph).to include(title: published_post.title, description: published_post.abstract, url: post_url(published_post.slug), image: published_post.cover_image_url) }
  end
end
