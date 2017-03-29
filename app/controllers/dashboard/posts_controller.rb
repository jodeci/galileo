# frozen_string_literal: true
class Dashboard::PostsController < Dashboard::BaseController
  # assign for active_decorator
  before_action :assign_current_collection, only: [:index, :taglist]
  before_action :assign_current_object, only: [:show, :edit]

  def taglist
    @current_collection = ::Post.dashboard.tagged_with(params[:name]).page(params[:page])
  end

  private

  def current_object
    @current_object ||= collection_scope.friendly.find(params[:id])
  end

  def collection_scope
    if params[:id]
      ::Post
    else
      ::Post.dashboard
    end
  end

  def resource_params
    params.require(:post).permit(
      :title, :body, :published_at, :abstract, :cover_image, :status, :tag_list, :slug, :featured
    )
  end
end
