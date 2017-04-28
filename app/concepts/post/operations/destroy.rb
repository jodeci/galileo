# frozen_string_literal: true
class Post::Destroy < Trailblazer::Operation
  step :process!

  def process!(options, params:, **)
    Post.find(params[:id]).destroy
  end
end
