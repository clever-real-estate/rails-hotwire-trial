module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :signed_in?
    before_action :require_login
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_login, **options
    end
  end

  private

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def signed_in?
    current_user.present?
  end

  def require_login
    return if signed_in?

    session[:return_to] = request.fullpath if request.get? || request.head?
    redirect_to sign_in_path, alert: "Please sign in to continue."
  end

  def log_in(user)
    reset_session
    session[:user_id] = user.id
    @current_user = user
  end

  def log_out
    reset_session
    @current_user = nil
  end
end
