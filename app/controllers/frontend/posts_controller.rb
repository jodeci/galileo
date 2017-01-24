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
    authenticate if @post.protected?
  end

  private

  # TODO: realm, username, password based on post?
  def authenticate
    authenticate_or_request("posts") do |username, password|
      username == Settings.basic_auth_user && password == Settings.basic_auth_password
    end
  end

  def authenticate_or_request(realm = "posts", &login_procedure)
    authenticate_with_http_basic(&login_procedure) || authentication_request(realm)
  end

  def authentication_request(realm)
    self.headers["WWW-Authenticate"] = %(Basic realm="#{realm.delete('"')}")
    self.status = 401
    render :error
  end
end
