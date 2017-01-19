# frozen_string_literal: true
class Frontend::PostsController < Frontend::BaseController
  private

  def collection_scope
    if params[:id]
      ::Post
    else
      ::Post.published
    end
  end
end
