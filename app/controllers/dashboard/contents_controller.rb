# frozen_string_literal: true
class Dashboard::ContentsController < Dashboard::BaseController
  private

  def collection_scope
    if params[:id]
      ::Content
    else
      ::Content.order(id: :desc)
    end
  end

  def resource_params
    params.require(:content).permit(
      :title, :body, :abstract, :template, :cover_image, :status
    )
  end
end
