# frozen_string_literal: true
require "rails_helper"

RSpec.describe Post::Create do
  subject do
    result = Post::Create.call(post)
    result["contract.default"]
  end

  context "valid post" do
    let(:post) do
      {
        title: "title",
        slug: "slug",
        status: "published",
        featured: true,
        cover_image: 1,
        published_at: "2017-01-01",
      }
    end
    it { expect(subject.model.persisted?).to be true }
  end

  context "empty title" do
    let(:post) { { title: nil } }
    it { expect(subject.errors[:title]).to include("未填寫") }
  end

  context "empty slug" do
    let(:post) { { slug: nil } }
    it { expect(subject.errors[:slug]).to include("未填寫") }
  end

  context "bad slug" do
    let(:post) { { slug: "中文" } }
    it { expect(subject.errors[:slug]).to include("只允許英數和連接符號") }
  end

  context "unique slug" do
    let(:post) { { title: "title", slug: "slug" } }
    before { Post::Create.call(post) }
    it { expect(subject.errors[:slug]).to include("已被使用") }
  end

  context "bad cover image" do
    let(:post) { { cover_image: "test" } }
    it { expect(subject.errors[:cover_image]).to include("圖檔主鍵需為正整數") }
  end

  context "feature published only" do
    let(:post) { { status: "draft", featured: true } }
    it { expect(subject.errors[:status]).to include("只能將公開文章設成精選") }
  end

  context "have date unless draft" do
    let(:post) { { status: "published", published_at: nil } }
    it { expect(subject.errors[:published_at]).to include("非草稿文章需設定發表日期") }
  end
end
