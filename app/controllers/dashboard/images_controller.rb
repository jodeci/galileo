# frozen_string_literal: true
class Dashboard::ImagesController < Dashboard::BaseController
  def taglist
    @current_collection ||= ::Image.dashboard.tagged_with(params[:name]).page(params[:page])
    render :index
  end

  private

  def collection_scope
    if params[:id]
      ::Image
    else
      ::Image.dashboard
    end
  end

  def resource_params
    params.require(:image).permit(:file, :caption, :tag_list)
  end
end
