# frozen_string_literal: true
class Post::Index < Trailblazer::Operation
  step :model!

  def model!(options, params:, **)
    options["model"] = Post.dashboard.page(params[:page])
  end
end
