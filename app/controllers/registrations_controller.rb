# frozen_string_literal: true
class RegistrationsController < Devise::RegistrationsController
  before_action :one_user_registered?, only: [:new, :create]

  protected

  # override devise for single user usage
  def one_user_registered?
    return unless User.count == 1
    redirect_to_login
  end

  private

  def redirect_to_login
    if user_signed_in?
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end
end
