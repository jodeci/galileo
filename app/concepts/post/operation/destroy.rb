# frozen_string_literal: true
class Post::Destroy < Trailblazer::Operation
  step :process!

  def process!(_options, params:, **)
    Post.find_by(id: params[:id]).destroy
  end
end
