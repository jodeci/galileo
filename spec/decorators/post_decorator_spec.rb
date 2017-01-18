# frozen_string_literal: true
require "rails_helper"

describe PostDecorator do
  let(:post) { Post.new.extend PostDecorator }
  subject { post }
  it { should be_a Post }
end
