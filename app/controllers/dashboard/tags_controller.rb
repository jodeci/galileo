# frozen_string_literal: true
class Dashboard::TagsController < Dashboard::BaseController
  private

  def collection_scope
    if params[:id]
      ::ActsAsTaggableOn::Tag
    else
      ::ActsAsTaggableOn::Tag.order(id: :desc)
    end
  end

  def resource_params
    params.require(:acts_as_taggable_on_tag).permit(:name)
  end
end
