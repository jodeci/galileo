# frozen_string_literal: true
class Post::Index < Trailblazer::Operation
  step :process!

  def process!(options, params:, **)
    options["posts"] = Post.dashboard.page(params[:page])
  end
end
