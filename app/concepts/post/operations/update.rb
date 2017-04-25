# frozen_string_literal: true
class Post::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Post, :find_by)
    step Contract::Build(constant: Post::Contract::Update)
  end

  step Nested(Present)
  step Contract::Validate()
  step Contract::Persist()
end
