class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :logged_in?, :current_user

  def authenticate_admin!
    redirect_to login_path unless current_user&.is_admin?
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "You must be logged in"
    end
  end

  def require_admin
    unless logged_in? && current_user.is_admin?
      redirect_to root_path, alert: "Access denied. Admin only."
    end
  end
end
