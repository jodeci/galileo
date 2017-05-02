# frozen_string_literal: true
require_dependency "app/concepts/post/contract/base"

class Post::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Post, :find_by)
    step Contract::Build(constant: Post::Contract::Update)
  end

  step Nested(Present)
  # step Contract::Validate(key: :post) # simple form
  step Contract::Validate() # cell
  step Contract::Persist()
end
