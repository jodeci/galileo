# frozen_string_literal: true
class Frontend::PostsController < Frontend::BaseController
  def taglist
  end

  private

  def collection_scope
    if params[:name]
      ::Post.published.tagged_with(params[:name])
    else
      ::Post.published
    end
  end
end
