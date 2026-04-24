class ApplicationController < ActionController::Base
  include SessionsHelper
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  before_action :require_login
  
  private
  
  def require_login
    unless logged_in?
      redirect_to sign_in_path
    end
  end
end
