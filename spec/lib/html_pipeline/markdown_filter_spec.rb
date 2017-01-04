# frozen_string_literal: false
require "rails_helper"

RSpec.describe HtmlPipeline::MarkdownFilter do
  subject do
    filter = HtmlPipeline::MarkdownFilter.new(doc)
    filter.call.to_s
  end

  context "input: <p>test</p>" do
    let(:doc) { "<p>test</p>" }
    it { expect(subject).to eq "<p>&lt;p&gt;test&lt;/p&gt;</p>" }
  end

  context "input: test" do
    let(:doc) { "test" }
    it { expect(subject).to eq "<p>test</p>" }
  end
end
