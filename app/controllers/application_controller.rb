class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :require_login

  private

  def current_user
    # TODO: Improvement opportunity to cache user lookup in the request store or use
    # Rails.cache to avoid repeated DB hits if current_user is called multiple times.
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_login
    redirect_to login_path, alert: "Nuh uh uh! You'd better sign in!" unless current_user
  end
end
