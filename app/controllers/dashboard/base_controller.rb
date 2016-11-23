# frozen_string_literal: true
class Dashboard::BaseController < Shikigami::BaseController
  before_action :force_login
  layout "dashboard"

  private

  def force_login
    redirect_to new_user_session_path unless user_signed_in?
  end
end
