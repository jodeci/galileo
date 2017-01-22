# frozen_string_literal: true
class Frontend::PagesController < Frontend::BaseController
  def index
    @posts = ::Post.featured.page(params[:page])
  end
end
