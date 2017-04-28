# frozen_string_literal: true
class Dashboard::PostsController < Dashboard::BaseController
  def index
    run ::Post::Index
    render cell(Post::Cell::Dashboard::Index, result["posts"])
  end

  def taglist
    run ::Post::Taglist
    render cell(Post::Cell::Dashboard::Taglist, result["posts"])
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

  def destroy
    run ::Post::Destroy
    redirect_to dashboard_posts_path
  end
end
