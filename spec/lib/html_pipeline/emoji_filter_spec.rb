# frozen_string_literal: true
require "rails_helper"

RSpec.describe HtmlPipeline::EmojiFilter do
  subject do
    filter = HtmlPipeline::EmojiFilter.new(doc)
    filter.call.to_s
  end

  context ":heart:" do
    let(:doc) { ":heart:" }
    it { expect(subject).to eq '<img draggable="false" title=":heart:" alt="❤" src="https://twemoji.maxcdn.com/2/svg/2764.svg" class="emoji">' }
  end
end
