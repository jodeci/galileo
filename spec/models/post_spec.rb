# frozen_string_literal: true
require "rails_helper"

RSpec.describe Post, type: :model do
  let(:published_post) { FactoryGirl.create(:post, :published) }
  let(:password_protected_post) { FactoryGirl.create(:post, :password_protected) }
  let(:draft_post) { FactoryGirl.create(:post, :draft) }
  let(:featured_post) { FactoryGirl.create(:post, :published, featured: true) }

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
