# frozen_string_literal: true
class Dashboard::ContentsController < Dashboard::BaseController
  def taglist
    @current_collection ||= ::Content.tagged_with(params[:name]).page(params[:page])
    render :index
  end

  private

  def current_object
    @current_object ||= collection_scope.friendly.find(params[:id])
  end

  def collection_scope
    if params[:id]
      ::Content
    else
      ::Content.order(id: :desc)
    end
  end

  def resource_params
    params.require(:content).permit(
      :title, :body, :published_at, :abstract, :template, :cover_image, :status, :tag_list, :slug
    )
  end
end
