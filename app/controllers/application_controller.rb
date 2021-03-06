class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_heroku_login


  private

  def require_heroku_login
    return true if current_user && current_user.access_token_expired_at.future?
    redirect_to login_path, alert: 'login failed!'
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  helper_method :current_user, :current_user=
end
