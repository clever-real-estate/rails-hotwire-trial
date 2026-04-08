class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :reset_development_session
  before_action :require_login
  helper_method :current_user

  SERVER_STARTED_AT = Time.now.to_i

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    redirect_to sign_in_path unless current_user
  end

  def reset_development_session
    return unless Rails.env.development?

    if Rails.cache.read("server_started_at") != SERVER_STARTED_AT
      reset_session
      Rails.cache.write("server_started_at", SERVER_STARTED_AT)
    end
  end


end
