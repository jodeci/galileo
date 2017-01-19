# frozen_string_literal: true
class Dashboard::PostsController < Dashboard::BaseController
  def taglist
  end

  private

  def collection_scope
    if params[:name]
      ::Post.tagged_with(params[:name])
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
