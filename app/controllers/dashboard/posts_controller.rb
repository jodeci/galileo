# frozen_string_literal: true
class Dashboard::PostsController < Dashboard::BaseController
  def taglist
    @current_collection ||= ::Post.tagged_with(params[:name]).page(params[:page])
    render :index
  end

  private

  def current_object
    @current_object ||= collection_scope.friendly.find(params[:id])
  end

  def collection_scope
    if params[:id]
      ::Post
    else
      ::Post.order(id: :desc)
    end
  end

  def resource_params
    params.require(:post).permit(
      :title, :body, :published_at, :abstract, :cover_image, :status, :tag_list, :slug
    )
  end
end
