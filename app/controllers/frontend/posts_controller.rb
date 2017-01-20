# frozen_string_literal: true
class Frontend::PostsController < Frontend::BaseController
  def taglist
    @current_collection = ::Post.published.tagged_with(params[:name]).page(params[:page])
  end

  private

  def collection_scope
    ::Post.published
  end
end
