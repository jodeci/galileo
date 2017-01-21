# frozen_string_literal: true
require "rails_helper"

describe PostDecorator, type: :decorator do
  before { FactoryGirl.create(:image) }
  let(:post) { FactoryGirl.create(:post, :public) }
  let(:decorated_post) { ActiveDecorator::Decorator.instance.decorate(post) }

  describe "#published_date" do
    it { expect(decorated_post.published_date).to eq "2014-03-18" }
  end

  describe "#status_translated" do
    it { expect(decorated_post.status_translated).to eq "公開" }
  end

  describe "#cover_image_tag" do
    it { expect(decorated_post.cover_image_tag).to eq %{<img src="#{store_dir_prefix}/image/file/1/medium_test.jpg" alt="Medium test" />} }
  end
end
