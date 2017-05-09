# frozen_string_literal: true
class Post::Taglist < Trailblazer::Operation
  step :model!

  def model!(options, params:, **)
    options["model"] = Post.dashboard.tagged_with(params[:name]).page(params[:page])
  end
end
