# frozen_string_literal: true
class Post::Taglist < Trailblazer::Operation
  step :process!

  def process!(options, params:, **)
    options["posts"] = Post.dashboard.tagged_with(params[:name]).page(params[:page])
  end
end
