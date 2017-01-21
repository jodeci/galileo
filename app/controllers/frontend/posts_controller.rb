# frozen_string_literal: true
class Frontend::PostsController < Frontend::BaseController
  def index
    @posts = ::Post.published.page(params[:page])
  end

  def taglist
    @posts = ::Post.published.tagged_with(params[:name]).page(params[:page])
  end

  def show
    @post = ::Post.published.find(params[:id])
  end
end
