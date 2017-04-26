# frozen_string_literal: true
class Dashboard::PostsController < Dashboard::BaseController
  # assign for active_decorator
  before_action :assign_current_collection, only: [:index, :taglist]

  def index
  end

  def taglist
    @current_collection = ::Post.dashboard.tagged_with(params[:name]).page(params[:page])
  end

  def show
    run ::Post::Show
    render cell(Post::Cell::Dashboard::Show, result["model"])
  end

  def new
    run ::Post::Create::Present
    render cell(Post::Cell::Dashboard::New, result["contract.default"])
  end

  def create
    run ::Post::Create do |result|
      return redirect_to edit_dashboard_post_path(result["model"].id)
    end
    render cell(Post::Cell::Dashboard::New, result["contract.default"])
  end

  def edit
    run ::Post::Update::Present
    render cell(Post::Cell::Dashboard::Edit, result["contract.default"])
  end

  def update
    run ::Post::Update do |result|
      return redirect_to edit_dashboard_post_path(result["model"].id)
    end
    render cell(Post::Cell::Dashboard::Edit, result["contract.default"])
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
end
