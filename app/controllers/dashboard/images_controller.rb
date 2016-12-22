# frozen_string_literal: true
class Dashboard::ImagesController < Dashboard::BaseController
  private

  def collection_scope
    if params[:id]
      ::Image
    else
      ::Image.order(id: :desc)
    end
  end

  def resource_params
    params.require(:image).permit(:file)
  end
end
