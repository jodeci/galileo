# frozen_string_literal: false
require "rails_helper"

describe ApplicationHelper, type: :helper do
  describe "#markdownify" do
    it { expect(markdownify("test")).to eq "<p>test</p>" }
  end

  describe "#foundation_icon" do
    it { expect(foundation_icon("paw")).to eq %(<i class="fi-paw"></i>) }
  end
end
