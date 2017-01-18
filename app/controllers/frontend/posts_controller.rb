# frozen_string_literal: true
class Frontend::PostsController < Frontend::BaseController
  def index
    current_collection
  end

  private

  def collection_scope
    if params[:id]
      ::Post
    else
      ::Post.order(id: :desc)
    end
  end
end
