# frozen_string_literal: true
require "rails_helper"

describe PostDecorator, type: :decorator do
  before { FactoryGirl.create(:image) }
  let(:public_post) { FactoryGirl.create(:post, :public, :abstract) }
  let(:draft_post) { FactoryGirl.create(:post, :draft) }
  let(:decorated_public) { ActiveDecorator::Decorator.instance.decorate(public_post) }
  let(:decorated_draft) { ActiveDecorator::Decorator.instance.decorate(draft_post) }

  describe "#published_date" do
    it { expect(decorated_public.published_date).to eq "2014-03-18" }
    it { expect(decorated_draft.published_date).to eq nil }
  end

  describe "#status_translated" do
    it { expect(decorated_public.status_translated).to eq "公開" }
  end

  describe "#abstract_text" do
    it { expect(decorated_public.abstract_text).to eq "abstract text" }
    it { expect(decorated_draft.abstract_text).to eq I18n.t("misc.default_abstract") }
  end

  describe "#description" do
    it { expect(decorated_public.description).to eq "abstract text" }
    it { expect(decorated_draft.description).to eq I18n.t("misc.default_description") }
  end

  describe "#cover_image_tag" do
    it { expect(decorated_public.cover_image_tag).to eq %(<img src="#{store_dir_prefix}/image/file/1/medium_test.jpg" alt="Medium test" />) }
  end

  describe "#cover_image_url" do
    it { expect(decorated_public.cover_image_url).to eq "http://test.host#{store_dir_prefix}/image/file/1/medium_test.jpg" }
    it { expect(decorated_draft.cover_image_url).to eq "http://test.host/assets/cover.jpg" }
  end

  describe "#open_graph" do
    it { expect(decorated_public.open_graph).to include(title: public_post.title, description: public_post.abstract, url: post_url(public_post.slug), image: public_post.cover_image_url) }
  end
end
