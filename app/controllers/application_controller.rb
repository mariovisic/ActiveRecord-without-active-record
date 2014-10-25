class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= session[:user_id].present? && User.find(session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  def ensure_authenticated
    unless user_signed_in?
      redirect_to new_session_path, flash: { error: 'You need to be logged in to view this page' }
    end
  end
end
