# frozen_string_literal: true
require "rails_helper"

describe PostDecorator, type: :decorator do
  let(:post) { FactoryGirl.create(:post, :public) }
  let(:decorated_post) { ActiveDecorator::Decorator.instance.decorate(post) }

  describe "#published_date" do
    it { expect(decorated_post.published_date).to eq "2014-03-18" }
  end

  describe "#status_translated" do
    it { expect(decorated_post.status_translated).to eq "公開" }
  end
end
